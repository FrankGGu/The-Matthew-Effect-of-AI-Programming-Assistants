(define/contract (detect-cycle head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([slow head] [fast head])
    (cond
      [(or (not fast) (not (list-node-next fast))) #f]
      [else
       (set! slow (list-node-next slow))
       (set! fast (list-node-next (list-node-next fast)))
       (if (eq? slow fast)
           (let ([ptr head])
             (let loop2 ([ptr ptr] [slow slow])
               (if (eq? ptr slow)
                   ptr
                   (loop2 (list-node-next ptr) (list-node-next slow)))))
           (loop slow fast))])))