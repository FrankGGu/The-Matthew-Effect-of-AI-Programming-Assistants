#lang racket

(define (lowest-common-ancestor root p q)
  (cond
    [(or (null? root) (eq? root p) (eq? root q)) root]
    [else
     (let ([left (lowest-common-ancestor (node-left root) p q)]
       (let ([right (lowest-common-ancestor (node-right root) p q)])
         (cond
           [(and (not (null? left)) (not (null? right))) root]
           [(not (null? left)) left]
           [else right])))]))