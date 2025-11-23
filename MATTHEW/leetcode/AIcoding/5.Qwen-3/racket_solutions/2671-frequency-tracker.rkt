#lang racket

(define (make-frequency-tracker)
  (let ((freq (hash)))
    (lambda (op . args)
      (cond
        [(equal? op 'add) (hash-set! freq (car args) (+ 1 (hash-ref freq (car args) 0)))]
        [(equal? op 'remove) (let ([v (hash-ref freq (car args) 0)])
                              (when (> v 0)
                                (hash-set! freq (car args) (- v 1))))]
        [(equal? op 'has) (not (zero? (hash-ref freq (car args) 0)))]
        [(equal? op 'get) (hash-values freq)]))))