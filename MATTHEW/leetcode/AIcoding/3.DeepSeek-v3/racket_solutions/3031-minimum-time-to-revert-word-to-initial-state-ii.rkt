#lang racket

(define (minimum-time-to-revert-word initial k)
  (define n (string-length initial))
  (define max-time (quotient n k))
  (define (can-revert? t)
    (let loop ((i (* t k)))
      (cond
        [(>= i n) #t]
        [(char=? (string-ref initial i) (string-ref initial (- i (* t k)))) (loop (+ i 1))]
        [else #f])))
  (let loop ((t 1))
    (cond
      [(> t max-time) n]
      [(can-revert? t) t]
      [else (loop (+ t 1))])))