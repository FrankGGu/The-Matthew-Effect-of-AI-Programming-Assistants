(define (findPeakGrid mat)
  (let* ((m (vector-length mat))
         (n (vector-length (vector-ref mat 0))))
    (letrec ((is-peak? (lambda (row col)
                          (and (>= row 0) (< row m) (>= col 0) (< col n)
                               (let ((val (vector-ref (vector-ref mat row) col)))
                                 (and (or (< 0 row) (>= val (vector-ref (vector-ref mat (- row 1)) col)))
                                      (or (>= (- m 1) row) (>= val (vector-ref (vector-ref mat (+ row 1)) col)))
                                      (or (< 0 col) (>= val (vector-ref (vector-ref mat row) (- col 1))))
                                      (or (>= (- n 1) col) (>= val (vector-ref (vector-ref mat row) (+ col 1))))))))))
             (binary-search (lambda (left right)
                              (if (>= left right)
                                  (let loop ((col left))
                                    (if (= col right)
                                        (let ((max-row (argmax (lambda (row) (vector-ref (vector-ref mat row) col)) (build-list m identity))))
                                          (if (is-peak? max-row col)
                                              (list max-row col)
                                              (if (and (< max-row (- m 1)) (>= (vector-ref (vector-ref mat (+ max-row 1)) col) (vector-ref (vector-ref mat max-row) col)))
                                                  (loop left)
                                                  (loop left))))
                                        (let ((max-row-left (argmax (lambda (row) (vector-ref (vector-ref mat row) left)) (build-list m identity)))
                                              (max-row-right (argmax (lambda (row) (vector-ref (vector-ref mat row) right)) (build-list m identity))))
                                          (cond
                                            [(is-peak? max-row-left left) (list max-row-left left)]
                                            [(is-peak? max-row-right right) (list max-row-right right)]
                                            [(and (< max-row-left (- m 1)) (>= (vector-ref (vector-ref mat (+ max-row-left 1)) left) (vector-ref (vector-ref mat max-row-left) left)))
                                             (loop left)]
                                            [(and (< max-row-right (- m 1)) (>= (vector-ref (vector-ref mat (+ max-row-right 1)) right) (vector-ref (vector-ref mat max-row-right) right)))
                                             (loop left)]
                                            [else (loop left)])))))
                                  (let ((mid (quotient (+ left right) 2)))
                                    (let ((max-row (argmax (lambda (row) (vector-ref (vector-ref mat row) mid)) (build-list m identity))))
                                      (if (is-peak? max-row mid)
                                          (list max-row mid)
                                          (cond
                                            [(and (< mid (- n 1)) (> (vector-ref (vector-ref mat max-row) (+ mid 1)) (vector-ref (vector-ref mat max-row) mid)))
                                             (binary-search (+ mid 1) right)]
                                            [(and (> mid 0) (> (vector-ref (vector-ref mat max-row) (- mid 1)) (vector-ref (vector-ref mat max-row) mid)))
                                             (binary-search left (- mid 1))]
                                            [else (binary-search (+ mid 1) right)]))))))))
      (binary-search 0 (- n 1)))))