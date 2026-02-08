(define (closest-nodes queries root)
  (define (inorder root acc)
    (cond [(null? root) acc]
          [else (inorder (bst-node-left root)
                        (append acc (list (bst-node-val root))
                                (inorder (bst-node-right root) acc)))]))

  (define sorted-values (inorder root '()))

  (define (find-closest-nodes query)
    (define (find-lower-bound lst query)
      (cond [(null? lst) -1]
            [(>= (car lst) query) -1]
            [else (let loop ([lst lst] [lower-bound -1])
                    (cond [(null? lst) lower-bound]
                          [(>= (car lst) query) lower-bound]
                          [else (loop (cdr lst) (car lst))]))]))

    (define (find-upper-bound lst query)
      (cond [(null? lst) -1]
            [(<= (car lst) query) -1]
            [else (car lst)]))

    (let* ([lower (find-lower-bound sorted-values query)]
           [upper (find-upper-bound (reverse sorted-values) query)])
      (list lower upper)))

  (map find-closest-nodes queries))