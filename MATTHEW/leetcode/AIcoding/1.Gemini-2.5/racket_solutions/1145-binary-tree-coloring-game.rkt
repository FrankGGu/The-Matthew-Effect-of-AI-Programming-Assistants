(struct TreeNode (val left right))

(define (b-tree-coloring-game root n x)
  (define left-subtree-size-of-x 0)
  (define right-subtree-size-of-x 0)

  (define (dfs node)
    (if (null? node)
        0
        (let* ((left-size (dfs (TreeNode-left node)))
               (right-size (dfs (TreeNode-right node))))
          (when (= (TreeNode-val node) x)
            (set! left-subtree-size-of-x left-size)
            (set! right-subtree-size-of-x right-size))
          (+ 1 left-size right-size))))

  (dfs root)

  (let* ((parent-subtree-size-of-x (- n 1 left-subtree-size-of-x right-subtree-size-of-x))
         (half-n (/ n 2.0)))

    (or (> left-subtree-size-of-x half-n)
        (> right-subtree-size-of-x half-n)
        (> parent-subtree-size-of-x half-n))))