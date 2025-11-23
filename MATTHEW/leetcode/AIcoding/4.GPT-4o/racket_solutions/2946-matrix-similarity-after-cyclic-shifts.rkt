(define (are-similar mat1 mat2)
  (define (shift-right lst)
    (cons (last lst) (butlast lst)))

  (define (matrix-to-list mat)
    (apply append mat))

  (define (check-similarity lst1 lst2)
    (let loop ((lst1 lst1) (lst2 lst2) (count 0))
      (cond
        ((= count (length lst1)) #f)
        ((equal? lst1 lst2) #t)
        (else (loop (shift-right lst1) lst2 (+ count 1))))))

  (let ((flat1 (matrix-to-list mat1))
        (flat2 (matrix-to-list mat2)))
    (check-similarity flat1 flat2)))