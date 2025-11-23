#lang racket

(define (longest-univalue-path root)
  (define max-length 0)
  (define (dfs node)
    (if (not node)
        0
        (let* ([left (dfs (node-left node))]
               [right (dfs (node-right node))]
               [left-len (if (equal? (node-val node) (node-val (node-left node))) (+ left 1) 0)]
               [right-len (if (equal? (node-val node) (node-val (node-right node))) (+ right 1) 0)]
               [current-len (+ left-len right-len)])
          (set! max-length (max max-length current-len))
          (max left-len right-len))))
  (dfs root)
  max-length)