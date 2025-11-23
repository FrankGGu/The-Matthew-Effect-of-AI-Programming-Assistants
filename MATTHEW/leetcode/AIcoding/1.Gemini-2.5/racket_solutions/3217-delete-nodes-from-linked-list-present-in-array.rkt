(define (delete-nodes head nums)
  (define delete-set (make-hash))
  (for-each (lambda (n) (hash-set! delete-set n #t)) nums)

  (define dummy (list-node 0 head))
  (define current-prev dummy)
  (define current-node head)

  (let loop ()
    (when current-node
      (if (hash-has-key? delete-set (list-node-val current-node))
          (begin
            (set-list-node-next! current-prev (list-node-next current-node))
            (set! current-node (list-node-next current-node)))
          (begin
            (set! current-prev current-node)
            (set! current-node (list-node-next current-node)))))
    (when current-node (loop)))

  (list-node-next dummy))