#lang racket

(define (lowest-common-ancestor root p q)
  (cond [(> (car p) (car root)) (lowest-common-ancestor (cadr root) p q)]
        [(< (car p) (car root)) (lowest-common-ancestor (caddr root) p q)]
        [else (car root)]))