(define (satisfies-conditions grid)
  (let* ([m (length grid)]
         [n (length (car grid))])

    (and
     ;; Condition 1: The value in each column is the same.
     (for/and ([j (in-range n)])
       (let ([col-val (list-ref (list-ref grid 0) j)])
         (for/and ([i (in-range 1 m)])
           (= (list-ref (list-ref grid i) j) col-val))))

     ;; Condition 2: The value in each column is strictly greater than the value in the previous column.
     (for/and ([j (in-range (- n 1))])
       (< (list-ref (list-ref grid 0) j)
          (list-ref (list-ref grid 0) (+ j 1)))))))