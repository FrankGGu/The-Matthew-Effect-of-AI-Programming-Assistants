(require data/queue)

(struct TreeNode (val left right))

(define (is-complete-tree root)
  (define q (make-queue))
  (queue-put! q root)

  (define found-null #f)

  (let loop ()
    (if (queue-empty? q)
        #t
        (let ([current-node (queue-get! q)])
          (cond
            [(not current-node)
             (set! found-null #t)
             (loop)]
            [else
             (if found-null
                 #f
                 (begin
                   (queue-put! q (TreeNode-left current-node))
                   (queue-put! q (TreeNode-right current-node))
                   (loop)))]))))