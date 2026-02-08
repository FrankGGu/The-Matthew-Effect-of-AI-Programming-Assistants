#lang racket

(define (max-fish grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define mutable-grid (make-vector m))
  (for ([r (in-range m)])
    (vector-set! mutable-grid r (list->vector (list-ref grid r))))

  (define max-f 0)

  (define (dfs r c)
    (if (or (< r 0) (>= r m) (< c 0) (>= c n)
            (zero? (vector-ref (vector-ref mutable-grid r) c)))
        0
        (begin
          (define fish-count (vector-ref (vector-ref mutable-grid r) c))
          (vector-set! (vector-ref mutable-grid r) c 0)
          (+ fish-count
             (dfs (+ r 1) c)
             (dfs (- r 1) c)
             (dfs r (+ c 1))
             (dfs r (- c 1))))))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (when (> (vector-ref (vector-ref mutable-grid r) c) 0)
        (set! max-f (max max-f (dfs r c))))))

  max-f)