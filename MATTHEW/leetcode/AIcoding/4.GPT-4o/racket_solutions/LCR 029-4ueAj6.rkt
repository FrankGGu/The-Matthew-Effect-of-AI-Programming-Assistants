(define-type Node
  (struct node (val next)))

(define (insert head insertVal)
  (define new-node (node insertVal #f))
  (if (null? head)
      (begin
        (set-node-next! new-node new-node)
        new-node)
      (begin
        (define current head)
        (define insert-point #f)
        (define max-node head)
        (do ()
            ((or (equal? (node-val current) insertVal)
                 (equal? (node-val max-node) (node-val head))))
          (if (< (node-val current) insertVal)
              (set! insert-point current))
          (set! max-node (if (> (node-val current) (node-val max-node))
                             current
                             max-node))
          (set! current (node-next current)))
        (if insert-point
            (begin
              (set-node-next! new-node (node-next insert-point))
              (set-node-next! insert-point new-node)
              head)
            (begin
              (set-node-next! new-node (node-next max-node))
              (set-node-next! max-node new-node)
              head))))))

(define (set-node-next! node next-node)
  (set! (node-next node) next-node))