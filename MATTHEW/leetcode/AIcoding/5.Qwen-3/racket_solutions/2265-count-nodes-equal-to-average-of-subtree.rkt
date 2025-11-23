#lang racket

(define (average-of-subtree root)
  (define/contract (helper node)
    (-> (or/c tree-node? #f) (values exact-integer? exact-integer?))
    (if (not node)
        (values 0 0)
        (let* ([left-sum left-count] (helper (tree-node-left node)))
              [right-sum right-count] (helper (tree-node-right node)))
              [total-sum (+ (tree-node-val node) left-sum right-sum)]
              [total-count (+ 1 left-count right-count)]
              [avg (quotient total-sum total-count)]
              [current (if (= (tree-node-val node) avg) 1 0)]
              [total-current (+ current (helper (tree-node-left node)) (helper (tree-node-right node)))]
              (values total-sum total-count))))
  (let ([result (helper root)])
    (car result)))

(define (count-nodes-equal-to-average-of-subtree root)
  (define/contract (helper node)
    (-> (or/c tree-node? #f) (values exact-integer? exact-integer? exact-integer?))
    (if (not node)
        (values 0 0 0)
        (let* ([left-sum left-count left-result] (helper (tree-node-left node)))
              [right-sum right-count right-result] (helper (tree-node-right node)))
              [total-sum (+ (tree-node-val node) left-sum right-sum)]
              [total-count (+ 1 left-count right-count)]
              [avg (quotient total-sum total-count)]
              [current (if (= (tree-node-val node) avg) 1 0)]
              [total-result (+ current left-result right-result)]
              (values total-sum total-count total-result))))
  (let ([result (helper root)])
    (third result)))