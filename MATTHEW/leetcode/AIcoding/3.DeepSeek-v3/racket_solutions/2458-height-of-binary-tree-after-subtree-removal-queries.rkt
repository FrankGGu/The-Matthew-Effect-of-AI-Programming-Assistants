#lang racket

(define (tree-height root)
  (if (null? root)
      0
      (+ 1 (max (tree-height (second root)) (tree-height (third root)))))

(define (get-heights root)
  (let loop ([node root] [h 0] [heights (hash)])
    (if (null? node)
        heights
        (let* ([left-heights (loop (second node) (+ h 1) heights)]
               [right-heights (loop (third node) (+ h 1) left-heights)])
          (hash-set right-heights (first node) h)))))

(define (get-max-heights root)
  (let loop ([node root] [max-left 0] [max-right 0] [max-heights (hash)])
    (if (null? node)
        max-heights
        (let* ([val (first node)]
               [new-max-left (max max-left (tree-height (second node)))]
               [new-max-right (max max-right (tree-height (third node)))]
               [new-max-heights (hash-set max-heights val (list new-max-left new-max-right))]
          (let* ([left-max-heights (loop (second node) new-max-left max-right new-max-heights)]
                 [right-max-heights (loop (third node) max-left new-max-right left-max-heights)])
            right-max-heights)))))

(define (tree-queries root queries)
  (let* ([heights (get-heights root)]
         [max-heights (get-max-heights root)]
    (for/list ([q queries])
      (let* ([h (hash-ref heights q)]
             [max-lr (hash-ref max-heights q)]
             [max-l (first max-lr)]
             [max-r (second max-lr)])
        (max (- (tree-height root) h 1) (+ h max-l) (+ h max-r))))))