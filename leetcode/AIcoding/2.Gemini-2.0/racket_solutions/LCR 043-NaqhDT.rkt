(define (TreeNode val)
  (list 'TreeNode val #f #f))

(define (TreeNode-val node)
  (cadr node))

(define (TreeNode-left node)
  (caddr node))

(define (TreeNode-right node)
  (cadddr node))

(define (set-TreeNode-left! node left)
  (set! (caddr node) left))

(define (set-TreeNode-right! node right)
  (set! (cadddr node) right))

(define (CBTInserter root)
  (let* ([tree root]
         [queue (list)])

    (define (find-incomplete-node)
      (set! queue (list tree))
      (let loop ()
        (if (empty? queue)
            #f
            (let* ([node (car queue)])
              (set! queue (cdr queue))
              (cond
                [(and node (not (TreeNode-left node)))
                 node]
                [(and node (not (TreeNode-right node)))
                 node]
                [node
                 (begin
                   (when (TreeNode-left node) (set! queue (append queue (list (TreeNode-left node)))))
                   (when (TreeNode-right node) (set! queue (append queue (list (TreeNode-right node)))))
                   (loop))]
                [else
                 (loop)])))))

    (define incomplete-node (find-incomplete-node))

    (define (insert val)
      (let ([new-node (TreeNode val)])
        (cond
          [(not incomplete-node)
           (begin
             (set! tree (TreeNode val))
             (set! incomplete-node tree)
             (TreeNode-val tree))]
          [(not (TreeNode-left incomplete-node))
           (begin
             (set-TreeNode-left! incomplete-node new-node)
             (if (TreeNode-right incomplete-node)
                 (set! incomplete-node (find-incomplete-node))
                 )
             (TreeNode-val incomplete-node))]
          [(not (TreeNode-right incomplete-node))
           (begin
             (set-TreeNode-right! incomplete-node new-node)
             (set! incomplete-node (find-incomplete-node))
             (TreeNode-val incomplete-node))]
          [else
           (error "Unexpected state: incomplete-node has both left and right children")])))

    (define (get-root)
      tree)

    (struct CBTInserter (insert get-root))
    (CBTInserter insert get-root)))