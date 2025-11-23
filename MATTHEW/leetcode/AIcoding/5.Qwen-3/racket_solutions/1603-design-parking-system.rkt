#lang racket

(define-struct parking-system (big small medium))

(define (make-parking-system big small medium)
  (make-parking-system big small medium))

(define (add-car system)
  (cond
    [(> (parkingsystem-big system) 0)
     (set-parking-system-big! system (- (parkingsystem-big system) 1))
     #t]
    [(> (parkingsystem-medium system) 0)
     (set-parking-system-medium! system (- (parkingsystem-medium system) 1))
     #t]
    [(> (parkingsystem-small system) 0)
     (set-parking-system-small! system (- (parkingsystem-small system) 1))
     #t]
    [else #f]))

(define (get-number-of-empty-slots system)
  (+ (parkingsystem-big system)
     (parkingsystem-medium system)
     (parkingsystem-small system)))