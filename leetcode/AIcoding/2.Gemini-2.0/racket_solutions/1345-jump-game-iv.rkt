(define (min-jumps arr)
  (let* ((n (length arr))
         (graph (make-hash))
         (visited (make-vector n #f)))
    (for/list ((i (in-range n)))
      (let ((val (vector-ref arr i)))
        (hash-update! graph val (lambda (x) (append x (list i))) '())))

    (letrec ((bfs (lambda (queue)
                      (cond
                        ((null? queue) -1)
                        (else
                         (let* ((curr (car queue))
                                (node (car curr))
                                (steps (cdr curr)))
                           (cond
                             ((= node (- n 1)) steps)
                             (else
                              (vector-set! visited node #t)
                              (let ((next-nodes (append
                                                  (list
                                                   (if (> node 0) (- node 1) #f)
                                                   (if (< node (- n 1)) (+ node 1) #f))
                                                  (hash-ref graph (vector-ref arr node) '()))))
                                (hash-remove! graph (vector-ref arr node))
                                (let ((valid-next-nodes (filter (lambda (x) (and x (not (vector-ref visited x)))) next-nodes)))
                                  (bfs (append (cdr queue) (map (lambda (x) (cons x (+ steps 1))) valid-next-nodes)))))))))))))
      (bfs (list (cons 0 0))))))