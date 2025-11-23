#lang racket

(define-struct atm (balance with-drawals))
(define (make-atm) (make-atm 0 '()))
(define (deposit atm amount)
  (define new-balance (+ (atm-balance atm) amount))
  (make-atm new-balance (cons amount (atm-with-drawals atm))))
(define (withdraw atm amount)
  (if (>= (atm-balance atm) amount)
      (let ((new-balance (- (atm-balance atm) amount)))
        (make-atm new-balance (cons amount (atm-with-drawals atm))))
      atm))
(define (get-balance atm) (atm-balance atm))
(define (get-withdrawals atm) (reverse (atm-with-drawals atm)))