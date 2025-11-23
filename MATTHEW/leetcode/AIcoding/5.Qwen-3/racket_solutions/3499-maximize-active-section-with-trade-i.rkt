#lang racket

(define (maximize-active-section-with-trade prices)
  (define (helper i buy? hold?)
    (cond [(>= i (length prices)) 0]
          [buy? (max (- (helper (+ i 1) #f #t) (list-ref prices i))
                     (helper (+ i 1) #t #f))]
          [hold? (max (helper (+ i 1) #f #t)
                      (helper (+ i 1) #t #t))]
          [else (max (helper (+ i 1) #t #f)
                     (helper (+ i 1) #f #f))]))
  (helper 0 #t #f))