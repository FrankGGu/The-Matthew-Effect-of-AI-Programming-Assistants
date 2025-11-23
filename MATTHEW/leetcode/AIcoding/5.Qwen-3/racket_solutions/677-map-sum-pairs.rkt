#lang racket

(define (make-map-sum-pairs)
  (let ([map (hash)])
    (lambda (op . args)
      (cond
        [(eq? op 'insert) (hash-set! map (car args) (cadr args))]
        [(eq? op 'sum) (for/sum ([k (in-hash-keys map)] #:when (string-prefix? k (car args))) (hash-ref map k))]))))