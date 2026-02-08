#lang racket

(define (widthOfBinaryTree root)
  (define (dfs node depth index result)
    (if (null? node)
      result
      (begin
        (define current-width (if (null? (list-ref result depth)) 0 (- index (list-ref result depth))))
        (set! result (if (< (length result) (+ 1 depth))
                         (append result (list index))
                         (list-set! result depth (list-ref result depth))))
        (dfs (node-left node) (+ depth 1) (* 2 index) result)
        (dfs (node-right node) (+ depth 1) (+ 1 (* 2 index)) result)
        (set! result (if (< (length result) (+ 1 depth))
                         result
                         (append result (list current-width))))))
  (define result '())
  (dfs root 0 0 result)
  (apply max result))

(define (node-left node) (if node (node-left node) '()))
(define (node-right node) (if node (node-right node) '()))