#lang racket

(define/contract (minimum-cost cake)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define m (length cake))
  (define n (if (null? cake) 0 (length (car cake))))

  (define (get-cost i j)
    (if (or (< i 0) (>= i m) (< j 0) (>= j n))
        0
        (list-ref (list-ref cake i) j)))

  (define dp (make-vector m (make-vector n 0)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref dp i) j
                   (if (and (zero? i) (zero? j))
                       (get-cost i j)
                       (min (if (> i 0) (vector-ref (vector-ref dp (- i 1)) j) +inf.0)
                            (if (> j 0) (vector-ref (vector-ref dp i) (- j 1)) +inf.0)
                            (get-cost i j))))))

  (vector-ref (vector-ref dp (- m 1)) (- n 1)))