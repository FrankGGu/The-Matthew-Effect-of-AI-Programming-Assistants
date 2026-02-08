(struct list-node (val next))

(define (middleNode head)
  (let loop ((slow head) (fast head))
    (cond
      ((or (null? fast) (null? (list-node-next fast)))
       slow)
      (else
       (loop (list-node-next slow) (list-node-next (list-node-next fast)))))))