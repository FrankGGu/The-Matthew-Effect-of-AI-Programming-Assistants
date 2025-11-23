#lang racket

(define (count-nodes root)
  (if (null? root)
      0
      (let ([left-height (left-depth root)]
            [right-height (right-depth root)])
        (if (= left-height right-height)
            (- (expt 2 left-height) 1)
            (+ 1 (count-nodes (left-node root)) (count-nodes (right-node root)))))))

(define (left-depth node)
  (if (null? node)
      0
      (+ 1 (left-depth (left-node node)))))

(define (right-depth node)
  (if (null? node)
      0
      (+ 1 (right-depth (right-node node)))))

(define (left-node node) (vector-ref node 1))
(define (right-node node) (vector-ref node 2))