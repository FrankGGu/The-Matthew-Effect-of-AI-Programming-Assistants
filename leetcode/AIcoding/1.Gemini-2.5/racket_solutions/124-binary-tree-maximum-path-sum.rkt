(define (max-path-sum root)
  (define max-sum -inf.0)

  (define (max-gain node)
    (if (null? node)
        0
        (let* ((left-gain (max 0 (max-gain (TreeNode-left node))))
               (right-gain (max 0 (max-gain (TreeNode-right node))))
               (current-node-val (TreeNode-val node)))

          (set! max-sum (max max-sum (+ current-node-val left-gain right-gain)))

          (+ current-node-val (max left-gain right-gain))))))

  (max-gain root)
  max-sum)