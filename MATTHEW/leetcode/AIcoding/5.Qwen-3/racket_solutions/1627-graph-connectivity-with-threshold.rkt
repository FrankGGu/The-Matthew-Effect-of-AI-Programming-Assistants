#lang racket

(define (are-connected n threshold u v)
  (define (find x)
    (if (= x (vector-ref parent x))
        x
        (vector-set! parent x (find (vector-ref parent x))))
    (vector-ref parent x))

  (define (union x y)
    (define fx (find x))
    (define fy (find y))
    (when (/= fx fy)
      (vector-set! parent fy fx)))

  (define parent (make-vector (+ n 1) 0))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! parent i i))

  (for ([i (in-range 1 (+ n 1))])
    (when (>= i threshold)
      (for ([j (in-range (* i 2) (+ n 1) i)])
        (union i j))))

  (= (find u) (find v)))