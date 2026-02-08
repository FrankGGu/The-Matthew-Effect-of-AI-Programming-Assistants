(define/contract (balance-bst root)
  (-> (or/c #f (list/c exact-integer? (or/c #f (list/c any/c any/c)) any/c)) (or/c #f (list/c exact-integer? (or/c #f (list/c any/c any/c)) any/c)))
  (define (in-order node)
    (if (false? node)
        '()
        (append (in-order (list-ref node 1)) (cons (list-ref node 0) (in-order (list-ref node 2))))))
  (define (build-balanced lst)
    (if (null? lst)
        #f
        (let* ([mid (quotient (length lst) 2)]
               [val (list-ref lst mid)]
               [left (build-balanced (take lst mid))]
               [right (build-balanced (drop lst (add1 mid)))])
          (list val left right))))
  (build-balanced (in-order root)))