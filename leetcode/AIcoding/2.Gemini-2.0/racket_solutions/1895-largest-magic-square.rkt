(define (largest-magic-square matrix)
  (define n (length matrix))
  (define m (length (first matrix)))

  (define (is-magic-square? row col k)
    (let* ((sum (apply + (take (drop (list-ref matrix row) col) k)))
           (check-row (lambda (r)
                        (equal? sum (apply + (take (drop (list-ref matrix r) col) k)))))
           (check-col (lambda (c)
                        (equal? sum (apply + (map (lambda (r) (list-ref (list-ref matrix r) (+ col c))) (range row (+ row k)))))))
           (check-diag1 (lambda ()
                         (equal? sum (apply + (map (lambda (i) (list-ref (list-ref matrix (+ row i)) (+ col i))) (range 0 k))))))
           (check-diag2 (lambda ()
                         (equal? sum (apply + (map (lambda (i) (list-ref (list-ref matrix (+ row i)) (+ col (- k 1 i)))) (range 0 k)))))))
      (and (ormap check-row (range row (+ row k)))
           (ormap check-col (range 0 k))
           (check-diag1)
           (check-diag2))))

  (let loop ((k (min n m)))
    (cond
      ((zero? k) 0)
      (else
       (let loop2 ((row 0))
         (cond
           ((>= row (- n k -1) 1)
            (let loop3 ((col 0))
              (cond
                ((>= col (- m k -1) 1)
                 (loop (- k 1)))
                ((is-magic-square? row col k) k)
                (else (loop3 (+ col 1))))))
           ((is-magic-square? row 0 k) k)
           (else (loop2 (+ row 1)))))))))