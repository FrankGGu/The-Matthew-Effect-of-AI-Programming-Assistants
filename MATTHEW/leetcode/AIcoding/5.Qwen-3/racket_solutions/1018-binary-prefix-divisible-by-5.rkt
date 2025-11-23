#lang racket

(define (prefix-divisible-by-5 a)
  (let loop ([a a] [current 0])
    (cond [(null? a) #t]
          [(= (modulo (modulo (+ current (* (car a) 10) 10) 5) 5) 0)
           (loop (cdr a) (modulo (+ current (* (car a) 10)) 5))]
          [else #f])))