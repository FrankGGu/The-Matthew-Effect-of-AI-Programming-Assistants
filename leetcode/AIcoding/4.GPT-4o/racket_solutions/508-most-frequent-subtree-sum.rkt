#lang racket

(define (find-frequent-tree-sum root)
  (define sums (make-hash))

  (define (subtree-sum node)
    (when node
      (let* ([left-sum (subtree-sum (node-left node))]
             [right-sum (subtree-sum (node-right node))]
             [total-sum (+ (node-val node) left-sum right-sum)])
        (hash-set! sums total-sum (add1 (hash-ref sums total-sum 0)))
        total-sum)))

  (subtree-sum root)
  (define max-freq (apply max (hash-values sums)))
  (filter (λ (x) (= (hash-ref sums x) max-freq)) (hash-keys sums)))

(define (node-left node) (if node (node-left node) 0))
(define (node-right node) (if node (node-right node) 0))
(define (node-val node) (if node (node-val node) 0))