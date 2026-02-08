#lang racket

(define (expand-binary-tree root)
  (cond
    [(null? root) null]
    [else
     (let* ([left (expand-binary-tree (car root))]
            [right (expand-binary-tree (caddr root))]
            [new-left (if (null? left) null (list (car root) left null))]
            [new-right (if (null? right) null (list (caddr root) null right))])
       (list (cadr root) new-left new-right))]))