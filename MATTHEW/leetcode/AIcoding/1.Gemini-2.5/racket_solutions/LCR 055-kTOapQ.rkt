(define-struct TreeNode (val left right))

(define-struct BSTIterator (stack) #:mutable)

(define (bst-iterator-init root)
  (let ((iter (BSTIterator '())))
    (define (_push-left node)
      (when node
        (set-bst-iterator-stack! iter (cons node (BSTIterator-stack iter)))
        (_push-left (TreeNode-left node))))
    (_push-left root)
    iter))

(define (bst-iterator-next obj)
  (let* ((s (BSTIterator-stack obj))
         (node (car s)))
    (set-bst-iterator-stack! obj (cdr s))

    (let ((right-child (TreeNode-right node)))
      (when right-child
        (let loop ((curr right-child))
          (when curr
            (set-bst-iterator-stack! obj (cons curr (BSTIterator-stack obj)))
            (set! curr (TreeNode-left curr))))))
    (TreeNode-val node)))

(define (bst-iterator-has-next? obj)
  (not (empty? (BSTIterator-stack obj))))