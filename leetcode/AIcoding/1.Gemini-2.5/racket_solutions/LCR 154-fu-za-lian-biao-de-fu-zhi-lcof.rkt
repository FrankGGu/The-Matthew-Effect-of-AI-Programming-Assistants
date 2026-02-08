(struct Node (val next random) #:mutable)

(define (copy-random-list head)
  (if (null? head)
      null
      (begin
        (define node-map (make-hash))

        (let loop ((current-original head))
          (unless (null? current-original)
            (hash-set! node-map current-original (Node (Node-val current-original) null null))
            (loop (Node-next current-original))))

        (let loop ((current-original head))
          (unless (null? current-original)
            (define new-node (hash-ref node-map current-original))

            (define original-next (Node-next current-original))
            (set-Node-next! new-node
                            (if (null? original-next)
                                null
                                (hash-ref node-map original-next)))

            (define original-random (Node-random current-original))
            (set-Node-random! new-node
                               (if (null? original-random)
                                   null
                                   (hash-ref node-map original-random)))

            (loop (Node-next current-original))))

        (hash-ref node-map head))))