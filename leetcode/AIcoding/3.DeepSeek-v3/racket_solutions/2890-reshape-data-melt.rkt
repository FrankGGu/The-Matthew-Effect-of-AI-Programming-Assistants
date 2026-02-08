(define (melt data id_vars value_vars var_name value_name)
  (define (get-row id-vars value-vars row)
    (for*/list ([id-var id-vars]
                [value-var value-vars])
      (append (map (lambda (var) (vector-ref row (hash-ref (car data) var))) id-vars)
              (list value-var)
              (list (vector-ref row (hash-ref (car data) value-var)))))

  (define new-data
    (for*/list ([row (cdr data)]
                [new-row (get-row id_vars value_vars row)])
      new-row)

  (define new-header
    (append id_vars (list var_name value_name)))

  (cons (make-hash (for/list ([(col idx) (in-indexed new-header)])
                   (hash-set! (make-hash) col idx))
        new-data))