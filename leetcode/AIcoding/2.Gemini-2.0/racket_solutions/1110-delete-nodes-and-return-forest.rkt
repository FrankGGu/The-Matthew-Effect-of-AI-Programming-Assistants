(define (del-nodes nodes to-delete)
  (define to-delete-set (set to-delete))
  (define result '())

  (define (helper node parent-deleted?)
    (cond
      [(null? node) null]
      [else
       (define deleted? (set-member? to-delete-set (car node)))
       (cond
         [deleted?
          (when (and (not parent-deleted?) (car node))
            (void))
          (define left (helper (cadr node) #t))
          (when left
            (unless (set-member? to-delete-set (car (cadr node)))
              (set! result (cons (cadr node) result))))
          (define right (helper (caddr node) #t))
          (when right
             (unless (set-member? to-delete-set (car (caddr node)))
              (set! result (cons (caddr node) result))))
          null]
         [else
          (when (and parent-deleted? (car node))
            (set! result (cons node result)))
          (helper (cadr node) #f)
          (helper (caddr node) #f)
          node])]))

  (define root-node (helper nodes #t))
  (when root-node
    (unless (set-member? to-delete-set (car nodes))
      (set! result (cons nodes result))))
  result)