(define (delete-nodes head to-delete)
  (define to-delete-set (make-hash))
  (for ([n (in-list to-delete)])
    (hash-set! to-delete-set n #t))

  (define (helper node prev-node)
    (cond
      [(null? node) '()]
      [(hash-ref to-delete-set (car node) #f)
       (cond
         [(null? prev-node)
          (helper (cdr node) null)]
         [else
          (helper (cdr node) prev-node)])]
      [else
       (cond
         [(null? prev-node)
          (cons (car node) (helper (cdr node) node))]
         [else
          (cons (car node) (helper (cdr node) node))])]))

  (helper head null))