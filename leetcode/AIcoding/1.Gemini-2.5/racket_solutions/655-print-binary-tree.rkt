(struct TreeNode (val left right))

(define (tree-height node)
  (if (null? node)
      -1
      (+ 1 (max (tree-height (TreeNode-left node))
                (tree-height (TreeNode-right node))))))

(define (print-tree root)
  (define h (tree-height root))
  (define m (+ h 1))
  (define n (- (expt 2 (+ h 1)) 1))

  (define matrix
    (build-vector m (lambda (r) (build-vector n (lambda (c) "")))))

  (define (fill-matrix node r c)
    (when (not (null? node))
      (vector-set! (vector-ref matrix r) c (number->string (TreeNode-val node)))

      (define offset (expt 2 (- h r 1)))

      (fill-matrix (TreeNode-left node) (+ r 1) (- c offset))

      (fill-matrix (TreeNode-right node) (+ r 1) (+ c offset))))

  (fill-matrix root 0 (/ (- n 1) 2))

  (map vector->list (vector->list matrix)))