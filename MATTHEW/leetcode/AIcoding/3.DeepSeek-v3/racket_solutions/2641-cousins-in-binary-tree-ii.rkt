#lang racket

(define (replace-value-in-tree root)
  (define (sum-levels root)
    (let loop ([nodes (list root)]
               [sums '()])
      (if (null? nodes)
          (reverse sums)
          (let* ([current-level (filter (lambda (x) (not (eq? x #f))) nodes)]
                 [current-sum (apply + (map (lambda (x) (if (number? x) x 0)) (map (lambda (n) (if (number? (node-val n)) (node-val n) 0)) current-level)))]
                 [next-nodes (append-map (lambda (n) (list (node-left n) (node-right n))) current-level)])
            (loop next-nodes (cons current-sum sums))))))

  (define sums (sum-levels root))

  (define (helper node depth parent-sum)
    (if (not node)
        #f
        (let* ([current-sum (list-ref sums (- (length sums) depth 1))]
               [new-val (- current-sum parent-sum (if (node-left node) (node-val (node-left node)) 0) (if (node-right node) (node-val (node-right node)) 0))]
               [new-node (node new-val
                              (helper (node-left node) (+ depth 1) (if (node-left node) (node-val (node-left node)) 0))
                              (helper (node-right node) (+ depth 1) (if (node-right node) (node-val (node-right node)) 0))])
          new-node)))

  (helper root 0 0))

(define (node val left right)
  (vector val left right))

(define (node-val n) (vector-ref n 0))
(define (node-left n) (vector-ref n 1))
(define (node-right n) (vector-ref n 2))