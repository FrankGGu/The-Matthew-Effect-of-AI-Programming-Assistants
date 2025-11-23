(define (isSubPath head root)
  (cond
    [(null? head) #t]
    [(null? root) #f]
    [else (or (equal? (list->string (map (λ (x) (number->string x)) (list-to-vector head)))
                  (list->string (map (λ (x) (number->string x)) (tree->list root))))
               (isSubPath head (hash-ref root 'left) )
               (isSubPath head (hash-ref root 'right)))]))

(define (tree->list root)
  (cond
    [(null? root) '()]
    [else
     (let loop ([node root] [path '()])
       (cond
         [(null? node) '()]
         [else (if (subpath? (cdr path) node)
                   (append path (list (hash-ref node 'val)))
                   (or (loop (hash-ref node 'left) (append path (list (hash-ref node 'val))))
                       (loop (hash-ref node 'right) (append path (list (hash-ref node 'val))))))])
       )]))

(define (subpath? head node)
  (cond
    [(null? head) #t]
    [(null? node) #f]
    [else (and (= (car head) (hash-ref node 'val))
                (or (subpath? (cdr head) (hash-ref node 'left))
                    (subpath? (cdr head) (hash-ref node 'right))))]))

(define (equal? lst1 lst2)
  (cond
    [(and (null? lst1) (null? lst2)) #t]
    [(or (null? lst1) (null? lst2)) #f]
    [(= (string-length lst1) (string-length lst2))
     (string=? lst1 lst2)]
    [else #f]))