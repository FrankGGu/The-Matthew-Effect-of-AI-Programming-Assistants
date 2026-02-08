(define (find-redundant-connection edges)
  (define max-node-id 0)
  (for-each (lambda (edge)
              (set! max-node-id (max max-node-id (car edge)))
              (set! max-node-id (max max-node-id (cadr edge))))
            edges)
  (define num-nodes (+ 1 max-node-id))

  (define parent (build-vector num-nodes (lambda (i) i)))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (begin
          (vector-set! parent i (find (vector-ref parent i)))
          (vector-ref parent i))))

  (define (union u v)
    (define root-u (find u))
    (define root-v (find v))
    (unless (= root-u root-v)
      (vector-set! parent root-v root-u)))

  (define result '())

  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (if (= (find u) (find v))
                  (set! result edge)
                  (union u v)))
            edges)
  result)