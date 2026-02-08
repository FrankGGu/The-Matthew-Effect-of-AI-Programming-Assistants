#lang racket

(define-struct TreeNode (val left right))

(define (findSubtreeSizes root queries)
  (define (size node)
    (if (null? node)
        0
        (+ 1 (size (TreeNode-left node)) (size (TreeNode-right node)))))

  (define (dfs node)
    (if (null? node)
        '()
        (cons (size node) (append (dfs (TreeNode-left node)) (dfs (TreeNode-right node))))))

  (define sizes (dfs root))
  (map (lambda (idx) (list-ref sizes idx)) queries))

(define (build-tree vals)
  (if (null? vals) 
      #f
      (let* ((root (TreeNode. (car vals) #f #f))
             (left-vals (cdr vals))
             (left (build-tree (if (null? left-vals) '() (list-ref left-vals 0))))
             (right (build-tree (if (< 1 (length left-vals)) (cdr left-vals) '()))))
             (new-root (TreeNode. (TreeNode-val root) left right)))
        new-root)))

(define (findSubtreeSizesAfterChanges root vals queries)
  (define tree (build-tree vals))
  (findSubtreeSizes tree queries))