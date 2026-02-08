(define (minPathCost grid moveCost)
  (let* ((m (length grid))
         (n (length (car grid)))
         (dp (make-vector m (make-vector n #f))))

    (define (solve row col)
      (cond
        [(>= row m) 0]
        [(vector-ref (vector-ref dp row) col) (vector-ref (vector-ref dp row) col)]
        [else
         (let* ((current-cost (list-ref (list-ref grid row) col))
                (next-row (+ row 1))
                (min-cost (for/fold (min #f) ((j (in-range n)))
                            (let ((move-cost-val (list-ref (list-ref moveCost current-cost) j)))
                              (if (not min)
                                  (+ move-cost-val (solve next-row j))
                                  (min min (+ move-cost-val (solve next-row j))))))))
           (vector-set! (vector-ref dp row) col min-cost)
           min-cost)]))

    (let ((result (for/fold (min #f) ((j (in-range n)))
                      (let ((initial-cost (list-ref (list-ref grid 0) j)))
                        (if (not min)
                            (+ initial-cost (solve 1 j))
                            (min min (+ initial-cost (solve 1 j))))))))
      result)))