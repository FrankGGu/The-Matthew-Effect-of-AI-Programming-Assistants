(define (leaf-similar? root1 root2)
  (define (get-leaves root)
    (cond
      [(null? root) '()]
      [(and (null? (car root)) (null? (cdr root))) (list (car root))]
      [else (append (get-leaves (car root)) (get-leaves (cdr root)))]))

  (equal? (get-leaves root1) (get-leaves root2)))