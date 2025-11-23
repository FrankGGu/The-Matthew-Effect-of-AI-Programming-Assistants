#lang racket

(define (corporate-flight-bookings bookings n)
  (let ([res (make-vector n 0)])
    (for-each
     (lambda (booking)
       (let ([start (car booking)]
             [end (cadr booking)]
             [k (caddr booking)])
         (vector-set! res (- start 1) (+ (vector-ref res (- start 1)) k))
         (when (< end n)
           (vector-set! res end (- (vector-ref res end) k)))))
     bookings)
    (for/fold ([sum 0] [result '()])
              ([i (in-range n)])
      (set! sum (+ sum (vector-ref res i)))
      (values sum (cons sum result)))
    (reverse result)))