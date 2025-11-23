(define (frog-position n edges t target)
  (define adj-list (make-hash))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (hash-set! adj-list u (cons v (hash-ref adj-list u '())))
                (hash-set! adj-list v (cons u (hash-ref adj-list v '())))))
            edges)

  (letrec ((dfs (lambda (current-node current-time current-prob parent-node)
                  (cond
                    ((> current-time t) 0.0)

                    ((= current-node target)
                     (let* ((neighbors (hash-ref adj-list current-node '()))
                            (effective-neighbors (filter (lambda (neighbor) (not (= neighbor parent-node))) neighbors))
                            (num-effective-neighbors (length effective-neighbors)))
                       (cond
                         ((= current-time t) current-prob)
                         ((= num-effective-neighbors 0) current-prob)
                         (else 0.0))))

                    (else
                     (let* ((neighbors (hash-ref adj-list current-node '()))
                            (effective-neighbors (filter (lambda (neighbor) (not (= neighbor parent-node))) neighbors))
                            (num-effective-neighbors (length effective-neighbors)))
                       (cond
                         ((= num-effective-neighbors 0) 0.0)
                         ((= current-time t) 0.0)
                         (else
                          (let ((prob-per-jump (/ current-prob num-effective-neighbors)))
                            (apply + (map (lambda (next-node)
                                            (dfs next-node (+ current-time 1) prob-per-jump current-node))
                                          effective-neighbors)))))))))))
    (dfs 1 0 1.0 0)))