#lang racket

(struct TreeNode (val left right) #:transparent)

(define (bstFromPreorder preorder)
  (define (build-tree lower upper)
    (if (or (null? preorder) 
            (> (car preorder) upper) 
            (< (car preorder) lower))
        #f
        (let ((root (car preorder)))
          (set! preorder (cdr preorder))
          (define node (TreeNode. root 
                                  (build-tree lower root) 
                                  (build-tree root upper)))
          node)))
  (build-tree -inf +inf))