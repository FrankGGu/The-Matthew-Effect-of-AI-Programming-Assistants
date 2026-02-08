#lang racket

(define/contract (average-of-levels root)
  (-> (or/c null? tree-node?) (listof flonum?))
  (if (null? root)
      '()
      (let loop ([nodes (list root)])
        (if (null? nodes)
            '()
            (let* ([vals (map (lambda (n) (tree-node-val n)) nodes]
                   [avg (/ (apply + vals) (length vals))]
                   [children (append* (map (lambda (n)
                                             (filter (lambda (x) (not (null? x)))
                                                     (list (tree-node-left n) (tree-node-right n))))
                                           nodes))])
              (cons (exact->inexact avg) (loop children))))))

(define-struct tree-node
  ([val #:mutable]
   [left #:mutable]
   [right #:mutable])
  #:transparent)