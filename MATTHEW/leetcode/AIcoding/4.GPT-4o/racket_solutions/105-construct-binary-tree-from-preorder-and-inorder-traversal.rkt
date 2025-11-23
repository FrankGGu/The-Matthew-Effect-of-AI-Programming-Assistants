(define-struct TreeNode (val left right))

(define (buildTree preorder inorder)
  (define (helper pre-start pre-end in-start in-end)
    (if (>= pre-start pre-end)
        #f
        (let* ((root-val (list-ref preorder pre-start))
               (root (make-TreeNode root-val))
               (in-root-index (index-of inorder root-val in-start in-end))
               (left-size (- in-root-index in-start)))
          (set! (TreeNode-left root) (helper (+ pre-start 1) (+ pre-start 1 left-size) in-start in-root-index))
          (set! (TreeNode-right root) (helper (+ pre-start 1 left-size) pre-end (+ in-root-index 1) in-end))
          root)))
  (helper 0 (length preorder) 0 (length inorder))

(define (index-of lst val start end)
  (for/fold ([i start]) ([x (in-range start end)])
    (if (equal? (list-ref lst x) val) x i)))