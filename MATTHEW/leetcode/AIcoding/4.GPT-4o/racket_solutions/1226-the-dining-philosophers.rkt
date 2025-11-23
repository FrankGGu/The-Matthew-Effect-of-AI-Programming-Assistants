#lang racket

(define philosophers (vector (make-parameter 0) (make-parameter 1) (make-parameter 2) (make-parameter 3) (make-parameter 4)))

(define (dine philosopher)
  (let ([left (modulo philosopher 5)]
        [right (modulo (+ philosopher 1) 5)])
    (define left-fork (vector-ref philosophers left))
    (define right-fork (vector-ref philosophers right))
    (define (pick-up)
      (left-fork 1)
      (right-fork 1))
    (define (put-down)
      (left-fork 0)
      (right-fork 0))
    (define (eat)
      (pick-up)
      (sleep (random 100))
      (put-down))
    (define (think)
      (sleep (random 100)))
    (define (loop)
      (think)
      (eat)
      (loop))
    (loop))

(define (create-philosopher id)
  (thread (lambda () (dine id))))

(define (start-dining)
  (for ([i (in-range 5)])
    (create-philosopher i)))