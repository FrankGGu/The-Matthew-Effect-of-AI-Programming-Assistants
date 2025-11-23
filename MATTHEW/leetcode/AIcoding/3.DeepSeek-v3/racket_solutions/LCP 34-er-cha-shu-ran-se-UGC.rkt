#lang racket

(define (max-value root k)
  (define (helper node k)
    (if (null? node)
        (cons 0 0)
        (let* ([left (helper (tree-node-left node) k)]
               [right (helper (tree-node-right node) k)]
               [not-taken (+ (car left) (car right))]
               [taken (tree-node-val node)]
               [max-taken taken])
          (for ([i (in-range 1 (add1 k))])
            (set! max-taken (max max-taken
                                 (+ (tree-node-val node)
                                    (if (>= i 1) (cdr left) 0)
                                    (if (>= i 1) (cdr right) 0))))
          (cons (max not-taken max-taken)
                not-taken))))
  (car (helper root k)))

(define-struct tree-node [val left right] #:transparent)