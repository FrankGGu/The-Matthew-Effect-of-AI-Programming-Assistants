(define (recover-tree root)
  (define first null)
  (define middle null)
  (define last null)
  (define prev (box null))

  (define (inorder node)
    (cond
      [(null? node) void]
      [else
       (inorder (bst-left node))
       (let ((current node))
         (cond
           [(and (not (null? (unbox prev))) (> (bst-val (unbox prev)) (bst-val current)))
            (cond
              [(null? first)
               (set! first (unbox prev))
               (set! middle current)]
              [else
               (set! last current)])]
           [else void])
         (set-box! prev current)
         (inorder (bst-right node)))]))

  (inorder root)

  (cond
    [(and (not (null? first)) (not (null? last)))
     (let ((temp (bst-val first)))
       (set-bst-val! first (bst-val last))
       (set-bst-val! last temp))]
    [(and (not (null? first)) (not (null? middle)))
     (let ((temp (bst-val first)))
       (set-bst-val! first (bst-val middle))
       (set-bst-val! middle temp))]
    [else void])
  root)