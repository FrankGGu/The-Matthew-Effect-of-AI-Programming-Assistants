#lang racket

(require rackunit)
(require "solution.rkt")

(define (shuffler arr)
  (define n (vector-length arr))
  (define result (make-vector n))
  (define rand (make-parameter (random 1000000)))
  (for ([i (in-range n)])
    (define j (+ i (modulo (rand) (- n i))))
    (vector-set! result i (vector-ref arr j))
    (vector-set! arr j (vector-ref arr i)))
  result)

(define (shuffle arr)
  (shuffler arr))