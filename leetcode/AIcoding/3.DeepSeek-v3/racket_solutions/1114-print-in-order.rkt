#lang racket

(define print-sem (make-semaphore 1))
(define second-sem (make-semaphore 0))
(define third-sem (make-semaphore 0))

(define (first)
  (semaphore-wait print-sem)
  (display "first")
  (semaphore-post second-sem))

(define (second)
  (semaphore-wait second-sem)
  (display "second")
  (semaphore-post third-sem))

(define (third)
  (semaphore-wait third-sem)
  (display "third")
  (semaphore-post print-sem))

(define (print-in-order)
  (let ([t1 (thread first)]
        [t2 (thread second)]
        [t3 (thread third)])
  (thread-wait t1)
  (thread-wait t2)
  (thread-wait t3))