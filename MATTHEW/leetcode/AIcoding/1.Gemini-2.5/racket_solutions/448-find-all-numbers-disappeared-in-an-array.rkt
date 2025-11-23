#lang racket

(define (find-disappeared-numbers nums)
  (let* ([n (length nums)]
         [present-numbers (list->set nums)])
    (for/list ([i (in-range 1 (add1 n))]
               #:when (not (set-member? present-numbers i)))
      i)))