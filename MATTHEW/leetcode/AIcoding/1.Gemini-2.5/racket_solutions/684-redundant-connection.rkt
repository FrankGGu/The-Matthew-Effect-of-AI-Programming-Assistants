(define (find-redundant-connection edges)
  (let* ((n (length edges))
         (parent (make-vector (+ n 1)))
         (rank (make-vector (+ n 1) 0)))

    (for ((i (in-range 1 (+ n 1))))
      (vector-set! parent i i))

    (define (find i)
      (if (= (vector-ref parent i) i)
          i
          (let ((root (find (vector-ref parent i))))
            (vector-set! parent i root)
            root)))

    (define (union u v)
      (let ((root-u (find u))
            (root-v (find v)))
        (if (= root-u root-v)
            #f
            (begin
              (let ((rank-u (vector-ref rank root-u))
                    (rank-v (vector-ref rank root-v)))
                (cond
                  ((> rank-u rank-v) (vector-set! parent root-v root-u))
                  ((< rank-u rank-v) (vector-set! parent root-u root-v))
                  (else
                   (vector-set! parent root-v root-u)
                   (vector-set! rank root-u (+ rank-u 1)))))
              #t))))

    (for/last ((edge (in-list edges)))
      (let ((u (car edge))
            (v (cadr edge)))
        (when (not (union u v))
          (list u v))))))