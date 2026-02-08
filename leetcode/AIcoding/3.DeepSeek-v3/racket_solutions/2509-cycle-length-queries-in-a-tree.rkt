(define (cycle-length-queries n queries)
  (define (get-depth x)
    (let loop ([x x] [depth 0])
      (if (= x 1) depth (loop (quotient x 2) (add1 depth)))))

  (define (get-path x)
    (let loop ([x x] [path '()])
      (if (= x 1) (cons 1 path) (loop (quotient x 2) (cons x path)))))

  (map (lambda (query)
         (let* ([a (car query)]
                [b (cadr query)]
                [path-a (get-path a)]
                [path-b (get-path b)]
                [lca (let loop ([pa path-a] [pb path-b])
                       (if (or (null? pa) (null? pb) (not (= (car pa) (car pb))))
                           (if (null? pa) (car pb) (car pa))
                           (loop (cdr pa) (cdr pb))))]
                [depth-a (get-depth a)]
                [depth-b (get-depth b)]
                [depth-lca (get-depth lca)])
           (+ 1 (- depth-a depth-lca) (- depth-b depth-lca))))
       queries))