#lang racket

(define (smallest-missing-genetic-value parents nums)
  (define n (length parents))
  (define adj (make-vector n '()))

  (define parents-vec (list->vector parents))
  (define nums-vec (list->vector nums))

  (for ([i (in-range 1 n)])
    (define p (vector-ref parents-vec i))
    (vector-set! adj p (cons i (vector-ref adj p))))

  (define ans (make-vector n 0))

  (define (dfs u parent)
    (define current-set (hash-set (vector-ref nums-vec u)))

    (for ([v (vector-ref adj u)])
      (when (not (= v parent))
        (define child-set (dfs v u))

        (when (> (hash-set-count child-set) (hash-set-count current-set))
          (define temp current-set)
          (set! current-set child-set)
          (set! child-set temp))

        (for ([val (in-hash-set child-set)])
          (hash-set-add! current-set val))))

    (define current-k 1)
    (while (hash-set-contains? current-set current-k)
      (set! current-k (+ current-k 1)))
    (vector-set! ans u current-k)

    current-set)

  (dfs 0 -1)

  (vector->list ans))