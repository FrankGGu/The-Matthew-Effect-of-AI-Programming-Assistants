(define (properties-graph edges properties)
  (let* ([n (length properties)]
         [adj-list (make-vector n '())]
         [visited (make-vector n #f)])
    (for ([edge edges])
      (let ([u (car edge)]
            [v (cdr edge)])
        (vector-set! adj-list u (cons v (vector-ref adj-list u)))
        (vector-set! adj-list v (cons u (vector-ref adj-list v)))))

    (define (dfs start-node)
      (let loop ([nodes (list start-node)]
                 [component (list)])
        (if (null? nodes)
            (list->set component)
            (let* ([node (car nodes)])
              (if (vector-ref visited node)
                  (loop (cdr nodes) component)
                  (begin
                    (vector-set! visited node #t)
                    (loop (append (cdr nodes) (vector-ref adj-list node)) (cons node component))))))))

    (define components (list))
    (for ([i (range n)])
      (unless (vector-ref visited i)
        (set! components (cons (dfs i) components))))

    (define (same-property? component)
      (let ([first-property (list-ref properties (set-first component))])
        (for ([node (set->list component)])
          (unless (equal? (list-ref properties node) first-property)
            (return #f)))
        #t))

    (length (filter same-property? components))))