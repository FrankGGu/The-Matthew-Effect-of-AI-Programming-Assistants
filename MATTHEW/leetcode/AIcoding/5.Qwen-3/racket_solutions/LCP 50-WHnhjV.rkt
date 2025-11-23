#lang racket

(define (num-jewels-in-stones jewels stones)
  (define jewel-set (string->set jewels))
  (for/sum ([c (in-string stones)])
    (if (set-member? jewel-set c) 1 0)))