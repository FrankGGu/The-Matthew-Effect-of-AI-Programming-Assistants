(struct node (val next) #:mutable)

(define (remove-nth-from-end head n)
  (define dummy (node 0 head))
  (define slow dummy)
  (define fast dummy)

  (for ([_ (in-range n)])
    (set! fast (node-next fast)))

  (while (not (null? (node-next fast)))
    (set! slow (node-next slow))
    (set! fast (node-next fast)))

  (set-node-next! slow (node-next (node-next slow)))

  (node-next dummy))