#lang racket

(define (find-frequent-tree-sum root)
  (define sum-count (make-hash))
  (define max-count 0)

  (define (subtree-sum node)
    (if (null? node)
        0
        (let* ([left-sum (subtree-sum (list-ref node 1))]
               [right-sum (subtree-sum (list-ref node 2))]
               [total (+ (list-ref node 0) left-sum right-sum)])
          (hash-update! sum-count total add1 1)
          (set! max-count (max max-count (hash-ref sum-count total)))
          total)))

  (subtree-sum root)
  (for/list ([(k v) (in-hash sum-count)] #:when (= v max-count)) k))