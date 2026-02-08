(define (can-be-assigned n relations)
  (define graph (make-vector n '()))
  (for-each (lambda (relation)
              (let ((a (car relation))
                    (b (cadr relation)))
                (vector-set! graph a (cons b (vector-ref graph a)))
                (vector-set! graph b (cons a (vector-ref graph b)))))
            relations)

  (define colors (make-vector n -1))

  (define (dfs node color)
    (if (vector-ref colors node) 
        (equal? (vector-ref colors node) color)
        (begin
          (vector-set! colors node color)
          (for-each (lambda (neighbor)
                      (if (not (dfs neighbor (if (= color 0) 1 0)))
                          (error "Not bipartite")))
                    (vector-ref graph node))
          #t)))

  (for ([i (in-range n)])
    (when (and (= (vector-ref colors i) -1)
               (not (dfs i 0)))
      (return #f)))

  #t)

(define (assign-elements-to-groups n relations)
  (can-be-assigned n relations))

(assign-elements-to-groups 5 '((0 1) (1 2) (2 0) (3 4)))