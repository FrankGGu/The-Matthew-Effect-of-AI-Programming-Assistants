#lang racket

(define/contract (right-side-view root)
  (-> (or/c null? tree-node?) (listof exact-integer?))
  (if (null? root)
      '()
      (let loop ([nodes (list root)] [result '()])
        (if (null? nodes)
            (reverse result)
            (let* ([val (tree-node-val (last nodes))]
                   [next-nodes (append* (map (lambda (n)
                                               (filter (lambda (x) (not (null? x)))
                                                       (list (tree-node-left n) (tree-node-right n))))
                                             nodes))])
              (loop next-nodes (cons val result)))))))

(define-struct tree-node ([val #:mutable] left right) #:transparent)