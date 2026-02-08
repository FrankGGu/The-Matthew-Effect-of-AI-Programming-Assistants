(define (modify-matrix matrix)
  (define m (length matrix))
  (define n (length (car matrix)))

  (define col-maxes
    (build-list n
                (lambda (j)
                  (define current-column (map (lambda (row) (list-ref row j)) matrix))
                  (define non-negative-values (filter (lambda (x) (>= x 0)) current-column))
                  (if (empty? non-negative-values)
                      0
                      (apply max non-negative-values)))))

  (build-list m
              (lambda (i)
                (build-list n
                            (lambda (j)
                              (define original-val (list-ref (list-ref matrix i) j))
                              (if (= original-val -1)
                                  (list-ref col-maxes j)
                                  original-val))))))