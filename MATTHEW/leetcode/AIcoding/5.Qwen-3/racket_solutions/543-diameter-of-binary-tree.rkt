#lang racket

(define (diameter-of-binary-tree root)
  (define (depth node)
    (if (not node)
        0
        (let ([left (depth (car node))]
              [right (depth (cadr node))])
          (+ 1 (max left right)))))

  (define (diameter node)
    (if (not node)
        0
        (let ([left (depth (car node))]
              [right (depth (cadr node))])
          (max (+ left right)
               (diameter (car node))
               (diameter (cadr node))))))

  (diameter root))