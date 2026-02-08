#lang racket

(define (smallest-missing-value-subtree parents nums)
  (define n (length parents))
  (define children (make-vector n '()))
  (for ([i (in-range 1 n)])
    (define p (list-ref parents i))
    (vector-set! children p (cons i (vector-ref children p)))))

  (define result (make-vector n 1))
  (define visited (make-hash))

  (define (dfs u)
    (hash-set! visited (list-ref nums u) #t)
    (for ([v (vector-ref children u)])
      (dfs v))
    (let loop ([missing 1])
      (if (hash-has-key? visited missing)
          (loop (add1 missing))
          (vector-set! result u missing))))

  (dfs 0)
  (vector->list result))