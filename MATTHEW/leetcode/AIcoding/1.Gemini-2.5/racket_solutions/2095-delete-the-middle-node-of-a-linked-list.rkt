(define (delete-middle-node head)
  (if (or (null? head) (null? (list-node-next head)))
      null
      (let loop ((slow head)
                 (fast head)
                 (prev-slow null))
        (if (or (null? fast) (null? (list-node-next fast)))
            (begin
              (set-list-node-next! prev-slow (list-node-next slow))
              head)
            (loop (list-node-next slow)
                  (list-node-next (list-node-next fast))
                  slow)))))