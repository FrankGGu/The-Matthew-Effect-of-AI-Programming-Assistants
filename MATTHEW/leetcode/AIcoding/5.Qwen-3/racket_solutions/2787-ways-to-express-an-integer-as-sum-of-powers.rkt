#lang racket

(define (num-ways n)
  (define pow-set (set))
  (for ([i (in-range 1 (add1 (floor (sqrt n))))])
    (set-add! pow-set (expt i 2)))
  (define dp (make-hash))
  (hash-set! dp 0 1)
  (for ([num (in-set pow-set)])
    (for ([i (in-range num (add1 n))])
      (when (hash-has-key? dp (- i num))
        (hash-set! dp i (+ (hash-ref dp i 0) (hash-ref dp (- i num)))))))
  (hash-ref dp n 0))