(define (max-increasing-cells matrix)
  (let* ([m (length matrix)]
         [n (length (car matrix))]
         [cells (sort (for*/list ([i (in-range m)] [j (in-range n)]) (list (list i j) (list (list i j) (list (list i j) (list (list i j))))) (cons (list i j) (list (list i j) (list (list i j) (list (list i j))))))
                      (lambda (x y) (< (list-ref (car x) 0 (list-ref (car x) 1) (list-ref (car x) 2) (list-ref (car x) 3)) (list-ref (car y) 0 (list-ref (car y) 1) (list-ref (car y) 2) (list-ref (car y) 3)))))]
         [row-dp (make-vector m 0)]
         [col-dp (make-vector n 0)]
         [ans 0])

    (for ([cell (in-list cells)])
      (let* ([i (list-ref (car cell) 0)]
             [j (list-ref (car cell) 1)]
             [val (list-ref (car cell) 0 (list-ref (car cell) 1) (list-ref (car cell) 2) (list-ref (car cell) 3))]
             [curr-dp (+ 1 (max (vector-ref row-dp i) (vector-ref col-dp j)))]
             [ans (max ans curr-dp)])

        (vector-set! row-dp i curr-dp)
        (vector-set! col-dp j curr-dp)
       ))

    ans))