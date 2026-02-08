#lang racket

(require racket/hash)
(require racket/queue)

(define (min-jumps arr)
  (define n (vector-length arr))

  (when (= n 1)
    0)

  (define val-to-indices (make-hash))
  (for ([i (in-range n)])
    (define val (vector-ref arr i))
    (hash-set! val-to-indices val (cons i (hash-ref val-to-indices val '()))))

  (define q (make-queue))
  (enqueue! q (cons 0 0)) ; (index . steps)

  (define visited (make-hash))
  (hash-set! visited 0 #t)

  (let loop ()
    (unless (queue-empty? q)
      (define current (dequeue! q))
      (define curr-idx (car current))
      (define steps (cdr current))

      (when (= curr-idx (- n 1))
        steps)

      ;; Explore neighbors
      ;; 1. curr-idx + 1
      (let ([next-idx (+ curr-idx 1)])
        (when (and (< next-idx n) (not (hash-has-key? visited next-idx)))
          (hash-set! visited next-idx #t)
          (enqueue! q (cons next-idx (+ steps 1)))))

      ;; 2. curr-idx - 1
      (let ([next-idx (- curr-idx 1)])
        (when (and (>= next-idx 0) (not (hash-has-key? visited next-idx)))
          (hash-set! visited next-idx #t)
          (enqueue! q (cons next-idx (+ steps 1)))))

      ;; 3. Indices with the same value
      (define current-val (vector-ref arr curr-idx))
      (when (hash-has-key? val-to-indices current-val)
        (for ([next-idx (hash-ref val-to-indices current-val)])
          (unless (hash-has-key? visited next-idx)
            (hash-set! visited next-idx #t)
            (enqueue! q (cons next-idx (+ steps 1)))))
        ;; Optimization: Clear the list of indices for current-val
        ;; We don't need to process this value again from other nodes
        (hash-remove! val-to-indices current-val))

      (loop))))