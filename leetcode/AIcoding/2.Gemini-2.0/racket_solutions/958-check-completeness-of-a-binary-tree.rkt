(define (is-complete-tree root)
  (define (bfs root)
    (let loop ([queue (list root)] [null-found? #f])
      (cond
        [(empty? queue) #t]
        [else
         (let* ([node (car queue)]
                [rest-queue (cdr queue)])
           (cond
             [(null? node)
              (if null-found?
                  #t
                  (loop rest-queue #t))]
             [null-found? #f]
             [else
              (loop (append rest-queue (list (->left node) (->right node))) null-found?)]))])))
  (bfs root))