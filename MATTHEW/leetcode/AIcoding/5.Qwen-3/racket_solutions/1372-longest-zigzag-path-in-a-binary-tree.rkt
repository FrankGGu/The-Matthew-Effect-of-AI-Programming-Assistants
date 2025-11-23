#lang racket

(define (longest-zig-zag-path root)
  (define (dfs node dir)
    (if (not node)
        0
        (let ([left (dfs (node-left node) 'right)]
              [right (dfs (node-right node) 'left)])
          (max left right))))
  (dfs root #f))