(define-struct node (val left right next) #:mutable)

(define (connect root)
  (cond [(not root) #f]
        [else
         (let loop ([current root])
           (when current
             (when (node-left current)
               (set-node-right! (node-left current) (node-right current)))
             (when (node-right current)
               (set-node-next! (node-right current) (node-next (node-right current))))
             (loop (node-next current)))
           (when (node-left root)
             (connect (node-left root)))
           (when (node-right root)
             (connect (node-right root)))
           #t)]))