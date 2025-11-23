(define/contract (detect-cycle head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (let loop ([slow head] [fast head])
    (cond
      [(or (not fast) (not (list-node-next fast))) #f]
      [else
       (set! slow (list-node-next slow))
       (set! fast (list-node-next (list-node-next fast)))
       (when (eq? slow fast)
         (let find-start ([ptr1 head] [ptr2 slow])
           (if (eq? ptr1 ptr2)
               ptr1
               (find-start (list-node-next ptr1) (list-node-next ptr2)))))])))