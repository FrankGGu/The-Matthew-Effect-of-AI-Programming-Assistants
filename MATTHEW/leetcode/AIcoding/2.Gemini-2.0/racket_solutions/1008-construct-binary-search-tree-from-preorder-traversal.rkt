(define (bst-from-preorder preorder)
  (define (helper lower upper preorder-idx)
    (if (or (null? preorder-idx) (> (car preorder-idx) (length preorder)))
        (values null preorder-idx)
        (let ((val (list-ref preorder (car preorder-idx))))
          (if (or (< val lower) (> val upper))
              (values null preorder-idx)
              (let* ((root (make-node val))
                     (new-preorder-idx (list (+ (car preorder-idx) 1)))
                     (left-result (helper lower val new-preorder-idx))
                     (left-tree (car left-result))
                     (next-idx (cadr left-result))
                     (right-result (helper val upper next-idx))
                     (right-tree (car right-result))
                     (final-idx (cadr right-result)))
                (set-node-left! root left-tree)
                (set-node-right! root right-tree)
                (values root final-idx)))))))

  (define (make-node val)
    (vector val #f #f))

  (define (node-val node)
    (vector-ref node 0))

  (define (node-left node)
    (vector-ref node 1))

  (define (node-right node)
    (vector-ref node 2))

  (define (set-node-left! node left)
    (vector-set! node 1 left))

  (define (set-node-right! node right)
    (vector-set! node 2 right))

  (car (helper -inf.0 +inf.0 (list 0))))