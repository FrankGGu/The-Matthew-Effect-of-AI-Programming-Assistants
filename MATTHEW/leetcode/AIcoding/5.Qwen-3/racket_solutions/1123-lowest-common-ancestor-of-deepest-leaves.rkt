#lang racket

(define (lowest-common-ancestor root p q)
  (cond ((not root) #f)
        ((or (equal? root p) (equal? root q)) root)
        (else
         (let* ((left (lowest-common-ancestor (car (cdr root)) p q))
                (right (lowest-common-ancestor (car (cdr (cdr root))) p q)))
           (if (and left right) root (if left left right))))))