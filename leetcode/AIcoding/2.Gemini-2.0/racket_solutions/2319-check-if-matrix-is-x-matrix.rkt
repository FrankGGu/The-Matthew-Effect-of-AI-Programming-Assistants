(define (is-x-matrix matrix)
  (let* ([n (length matrix)])
    (and
     (for/and ([i (in-range n)]
               [j (in-range n)])
       (if (or (= i j) (= (+ i j) (- n 1)))
           (not (= (list-ref (list-ref matrix i) j) 0))
           (= (list-ref (list-ref matrix i) j) 0))))))