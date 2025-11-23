#lang racket

(define (num-ways n k)
  (define dp (make-vector k 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 k)])
    (vector-set! dp i
                 (for/sum ([j (in-range i)])
                   (vector-ref dp j))))
  (vector-ref dp (sub1 k)))

(define (main)
  (define input (read-line))
  (when input
    (let* ([n (string->number input)]
           [k (string->number (read-line))])
      (printf "~a\n" (num-ways n k)))
    (main)))

(main)