(define (maxStrictlyIncreasingCells matrix)
  (define rows (vector-length matrix))
  (define cols (vector-length (vector-ref matrix 0)))
  (define dp (make-vector rows (lambda () (make-vector cols 1))))
  (define indices (for/list ([i (in-range rows)] [j (in-range cols)]) 
                           (list (vector-ref (vector-ref matrix i) j) i j)))
  (define sorted-indices (sort indices (lambda (a b) (< (car a) (car b)))))

  (for-each (lambda (item)
              (define val (car item))
              (define r (cadr item))
              (define c (caddr item))
              (for-each (lambda (r2 c2)
                          (when (and (< (vector-ref (vector-ref matrix r2) c2) val)
                                     (< (vector-ref (vector-ref matrix r) c) val))
                            (vector-set! (vector-ref dp r) c 
                                         (max (vector-ref (vector-ref dp r) c)
                                              (+ 1 (vector-ref (vector-ref dp r2) c2))))))
                        (for/list ([r2 (in-range rows)]
                                    [c2 (in-range cols)]
                                    #:when (not (and (= r r2) (= c c2)))))
              ))
            sorted-indices)

  (define max-cells 0)
  (for-each (lambda (i)
              (for-each (lambda (j)
                          (set! max-cells (max max-cells (vector-ref (vector-ref dp i) j))))
                        (in-range cols)))
            (in-range rows))

  max-cells)