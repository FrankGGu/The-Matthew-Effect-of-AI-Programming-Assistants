(define (flatten head)
  (when (not head)
    (error 'flatten "Input head cannot be null"))

  (define (get-list-tail start-node)
    (let loop ((node start-node))
      (if (Node-next node)
          (loop (Node-next node))
          node)))

  (let loop ((current head))
    (when current
      (cond
        ((Node-child current)
         (define original-next (Node-next current))
         (set-Node-next! current (Node-child current))
         (set-Node-prev! (Node-child current) current)
         (set-Node-child! current #f)
         (define child-tail (get-list-tail (Node-next current)))
         (when original-next
           (set-Node-next! child-tail original-next)
           (set-Node-prev! original-next child-tail))
         (loop original-next))
        (else
         (loop (Node-next current))))))
  head)