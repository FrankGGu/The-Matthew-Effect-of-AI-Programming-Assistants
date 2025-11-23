#lang racket

(define (melt df)
  (define cols (car df))
  (define rows (cdr df))
  (define id-cols (take cols 1))
  (define value-cols (drop cols 1))
  (define id-values (map first rows))
  (define value-values (map (lambda (row) (drop row 1)) rows))
  (define result '())
  (for ([id id-values] [values value-values])
    (for ([i (in-range (length value-cols))])
      (set! result (cons (list (list-ref id 0) (list-ref value-cols i) (list-ref values i)) result))))
  (reverse result))