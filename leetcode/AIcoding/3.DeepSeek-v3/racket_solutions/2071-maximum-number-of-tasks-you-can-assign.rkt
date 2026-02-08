(define/contract (max-task-assign tasks workers pills strength)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([tasks (sort tasks <)]
         [workers (sort workers <)]
         [n (length tasks)]
         [m (length workers)]
         [can-assign? (lambda (k)
                        (let loop ([i (- k 1)] [j (- m 1)] [p pills] [used (make-hash)])
                          (cond
                            [(< i 0) #t]
                            [(< j 0) #f]
                            [(>= (list-ref workers j) (list-ref tasks i))
                             (loop (- i 1) (- j 1) p used)]
                            [(and (> p 0) (>= (+ (list-ref workers j) strength) (list-ref tasks i)))
                             (loop (- i 1) (- j 1) (- p 1) used)]
                            [else #f])))])
    (let binary-search ([left 0] [right (min n m)])
      (if (>= left right)
          left
          (let ([mid (quotient (+ left right 1) 2)])
            (if (can-assign? mid)
                (binary-search mid right)
                (binary-search left (- mid 1)))))))