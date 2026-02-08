#lang racket

(define-struct TreeNode (val left right))

(define (isSubtree s t)
  (if (null? s)
      #f
      (or (isSameTree s t)
          (or (isSubtree (TreeNode-left s) t)
              (isSubtree (TreeNode-right s) t)))))

(define (isSameTree p q)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [else (and (= (TreeNode-val p) (TreeNode-val q))
                (isSameTree (TreeNode-left p) (TreeNode-left q))
                (isSameTree (TreeNode-right p) (TreeNode-right q)))]))