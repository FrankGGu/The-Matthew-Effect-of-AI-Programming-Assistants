(define-struct TreeNode (val left right))

(define (minDepth root)
  (if (null? root)
      0
      (let ((left-depth (minDepth (TreeNode-left root)))
            (right-depth (minDepth (TreeNode-right root))))
        (if (zero? left-depth)
            (+ 1 right-depth)
            (if (zero? right-depth)
                (+ 1 left-depth)
                (+ 1 (min left-depth right-depth)))))))