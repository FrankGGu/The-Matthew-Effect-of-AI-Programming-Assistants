#lang racket

(define (invert-tree root)
  (if (null? root)
      null
      (let ([left (invert-tree (third root))]
            [right (invert-tree (fourth root))])
        (list (first root) (second root) right left))))

(define (sum-tree root)
  (if (null? root)
      0
      (+ (second root) (sum-tree (third root)) (sum-tree (fourth root)))))

(define (invert-subtree-sum root)
  (if (null? root)
      0
      (let* ([left (third root)]
             [right (fourth root)]
             [left-sum (invert-subtree-sum left)]
             [right-sum (invert-subtree-sum right)]
             [current-sum (sum-tree root)]
             [inverted-left (invert-tree left)]
             [inverted-right (invert-tree right)]
             [inverted-left-sum (if (null? left) 0 (sum-tree inverted-left))]
             [inverted-right-sum (if (null? right) 0 (sum-tree inverted-right))])
        (+ current-sum left-sum right-sum inverted-left-sum inverted-right-sum))))