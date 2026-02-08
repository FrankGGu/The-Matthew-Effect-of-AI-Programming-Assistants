#lang racket

(define (flatten root)
  (define (helper node)
    (cond
      [(null? node) null]
      [else
       (let* ([left-tail (helper (send node get-left))]
              [right-tail (helper (send node get-right))]
              [left (send node get-left)]
              [right (send node get-right)])
         (send node set-left null)
         (when (not (null? left))
           (send node set-right left)
           (when left-tail
             (send left-tail set-right right)))
         (cond
           [(not (null? right-tail)) right-tail]
           [(not (null? left-tail)) left-tail]
           [else node]))]))
  (helper root))