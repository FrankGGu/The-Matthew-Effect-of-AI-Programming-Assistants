#lang racket

(define (max-profit prices)
  (define (helper i hold cash)
    (cond [(= i (length prices)) (if hold 0 cash)]
          [else
           (let ([price (list-ref prices i)])
             (if hold
                 (max (- price cash) (helper (+ i 1) #t cash))
                 (max (helper (+ i 1) #f price) (helper (+ i 1) #t cash))))]))
  (helper 0 #f 0))