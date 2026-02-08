#lang racket

(define (kthLargestLevelSum root k)
  (define (level-sums node level sums)
    (if (null? node)
        sums
        (let ([sums (if (>= (length sums) level)
                        (list-set! sums (sub1 level) (+ (list-ref sums (sub1 level)) (node-val node)))
                        (append sums (list (node-val node))) )])
          (level-sums (left node) (add1 level) (level-sums (right node) (add1 level) sums)))))

  (define (node-val node) (if node (node-value node) 0))
  (define (left node) (if node (node-left node) #f))
  (define (right node) (if node (node-right node) #f))

  (define sums (level-sums root 1 '()))
  (define sorted-sums (sort sums >))
  (if (>= (length sorted-sums) k)
      (list-ref sorted-sums (sub1 k))
      -1))