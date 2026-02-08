#lang racket

(define (navigation-device points)
  (let* ((n (length points))
         (dp (make-vector n 0)))

    (when (> n 0)
      (vector-set! dp 0 (car points)))

    (when (> n 1)
      (vector-set! dp 1 (+ (car (cdr points)) (vector-ref dp 0))))

    (for ([i (range 2 n)])
      (vector-set! dp i
                   (+ (list-ref points i)
                      (min (vector-ref dp (- i 1))
                           (vector-ref dp (- i 2))))))

    (if (> n 0)
        (vector-ref dp (- n 1))
        0)))