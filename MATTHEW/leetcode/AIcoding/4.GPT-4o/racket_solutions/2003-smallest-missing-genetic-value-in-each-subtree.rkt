#lang racket

(struct TreeNode (val left right))

(define (smallestMissingValue root)
  (define (dfs node)
    (if (null? node)
        (list)
        (let* ((left-values (dfs (TreeNode-left node)))
               (right-values (dfs (TreeNode-right node)))
               (all-values (append (list (TreeNode-val node)) left-values right-values))
               (max-val (if (null? all-values) 0 (apply max all-values)))
               (missing (find-missing all-values max-val)))
          (cons missing (list all-values)))))

  (define (find-missing values max-val)
    (let loop ((i 1))
      (if (and (<= i max-val) (member i values))
          (loop (+ i 1))
          i)))

  (map first (dfs root)))

(define (smallestMissingValueInEachSubtree root)
  (smallestMissingValue root))