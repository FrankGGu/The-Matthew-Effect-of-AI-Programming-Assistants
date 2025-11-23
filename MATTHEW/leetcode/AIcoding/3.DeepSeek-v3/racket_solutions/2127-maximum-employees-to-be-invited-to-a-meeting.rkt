#lang racket

(define (maximum-invitations favorite)
  (define n (vector-length favorite))
  (define visited (make-vector n #f))
  (define max-cycle 0)
  (define pairs '())

  (define (dfs u)
    (define path '())
    (let loop ([u u] [depth 0])
      (cond
        [(vector-ref visited u)
         (let ([pos (index-of path u)])
           (if pos (- depth pos) 0))]
        [else
         (vector-set! visited u #t)
         (set! path (cons u path))
         (loop (vector-ref favorite u) (+ depth 1))])))

  (for ([u (in-range n)])
    (unless (vector-ref visited u)
      (let ([cycle-len (dfs u)])
        (when (> cycle-len 2)
          (set! max-cycle (max max-cycle cycle-len)))
        (when (= cycle-len 2)
          (set! pairs (cons (list u (vector-ref favorite u)) pairs))))))

  (define pair-used (make-hash))
  (define pair-sum 0)

  (for ([pair pairs])
    (unless (hash-ref pair-used (sort pair <) #f)
      (hash-set! pair-used (sort pair <) #t)
      (define a (first pair))
      (define b (second pair))
      (define len-a (max-path b a))
      (define len-b (max-path a b))
      (set! pair-sum (+ pair-sum len-a len-b))))

  (max max-cycle pair-sum))

(define (max-path start avoid)
  (define n (vector-length favorite))
  (define visited (make-vector n #f))
  (vector-set! visited avoid #t)
  (define q (make-queue))
  (enqueue! q start)
  (vector-set! visited start #t)
  (define depth 0)

  (let loop ()
    (unless (queue-empty? q)
      (define size (queue-length q))
      (set! depth (+ depth 1))
      (for ([_ (in-range size)])
        (define u (dequeue! q))
        (for ([v (in-range n)])
          (when (and (= (vector-ref favorite v) u) (not (vector-ref visited v)))
            (vector-set! visited v #t)
            (enqueue! q v)))
      (loop)))
  depth)

(define favorite (vector 2 2 1 2))
(maximum-invitations favorite)