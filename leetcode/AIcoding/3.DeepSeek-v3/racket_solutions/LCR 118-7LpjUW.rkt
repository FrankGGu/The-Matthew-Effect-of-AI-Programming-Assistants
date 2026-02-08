(define (find-redundant-connection edges)
  (define parent (make-hash))

  (define (find u)
    (if (hash-has-key? parent u)
        (let ((p (hash-ref parent u)))
        (if (equal? p u)
            u
            (let ((root (find p)))
              (hash-set! parent u root)
              root))
        (begin
          (hash-set! parent u u)
          u)))

  (define (union u v)
    (let ((root-u (find u))
          (root-v (find v)))
      (if (equal? root-u root-v)
          #f
          (begin
            (hash-set! parent root-u root-v)
            #t))))

  (for/first ([edge (in-list edges)]
              [u (in-value (first edge))]
              [v (in-value (second edge))]
              #:when (not (union u v)))
    edge))