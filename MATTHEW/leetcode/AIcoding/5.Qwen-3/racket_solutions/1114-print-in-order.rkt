#lang racket

(define (print-in-order)
  (let ([a (make-semaphore 0)]
        [b (make-semaphore 0)])
    (define (first)
      (printf "first\n")
      (semaphore-post a))
    (define (second)
      (semaphore-wait a)
      (printf "second\n")
      (semaphore-post b))
    (define (third)
      (semaphore-wait b)
      (printf "third\n"))
    (thread (lambda () (first)))
    (thread (lambda () (second)))
    (thread (lambda () (third)))))