#lang racket

(define (get-target-copy original cloned target)
  (cond
    [(null? original) #f]
    [(eq? original target) cloned]
    [else
     (or (get-target-copy (send original get-left) (send cloned get-left) target)
         (get-target-copy (send original get-right) (send cloned get-right) target))]))