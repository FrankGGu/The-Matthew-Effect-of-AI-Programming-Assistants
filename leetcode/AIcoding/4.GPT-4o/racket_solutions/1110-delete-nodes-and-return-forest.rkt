#lang racket

(struct TreeNode (val left right) #:transparent)

(define (delNodes root to_delete)
  (define (helper node to_delete-set)
    (if (null? node)
        '()
        (let* ((deleted (set-member? to_delete-set (TreeNode-val node)))
               (left-children (helper (TreeNode-left node) to_delete-set))
               (right-children (helper (TreeNode-right node) to_delete-set))
               (result (if deleted '() (cons node (append left-children right-children)))))
          (if deleted
              (append left-children right-children)
              result))))

  (define to-delete-set (set (map (lambda (x) (TreeNode x)) to_delete)))
  (helper root to-delete-set))

(define (delNodes-main root to_delete)
  (delNodes root (set (map (lambda (x) x) to_delete))))