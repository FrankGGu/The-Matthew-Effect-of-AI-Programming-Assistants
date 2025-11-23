(define-struct TreeNode (val left right))

(define (bst-from-preorder preorder)
  (define len (length preorder))
  (define current-idx (box 0))

  (define (build-tree lower-bound upper-bound)
    (if (or (>= (unbox current-idx) len)
            (< (list-ref preorder (unbox current-idx)) lower-bound)
            (> (list-ref preorder (unbox current-idx)) upper-bound))
        #f
        (let ((val (list-ref preorder (unbox current-idx))))
          (set-box! current-idx (+ (unbox current-idx) 1))
          (let ((left-child (build-tree lower-bound val)))
            (let ((right-child (build-tree val upper-bound)))
              (TreeNode val left-child right-child))))))

  (build-tree -inf.0 +inf.0))