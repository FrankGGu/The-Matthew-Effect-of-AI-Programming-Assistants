(define (valid-path n edges source destination)
  (define adj-list (make-hash))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (hash-update! adj-list u (lambda (neighbors) (cons v neighbors)) '())
                (hash-update! adj-list v (lambda (neighbors) (cons u neighbors)) '())))
            edges)

  (define visited (make-vector n #f))

  (define (dfs node)
    (if (vector-ref visited node)
        #f
        (begin
          (vector-set! visited node #t)
          (if (= node destination)
              #t
              (let ((neighbors (hash-ref adj-list node '())))
                (ormap dfs neighbors))))))

  (dfs source))