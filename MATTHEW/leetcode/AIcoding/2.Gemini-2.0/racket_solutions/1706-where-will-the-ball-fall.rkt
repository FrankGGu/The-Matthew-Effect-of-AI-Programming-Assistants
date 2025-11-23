(define (find-ball grid)
  (let* ((rows (length grid))
         (cols (length (car grid))))
    (for/list ((i (in-range (length (car grid)))))
      (let loop ((row 0) (col i))
        (cond
          ((= row rows) col)
          ((or (< col 0) (= col cols)) -1)
          (else
           (let ((val (list-ref (list-ref grid row) col)))
             (cond
               ((= val 1)
                (if (or (= (+ col 1) cols) (= (list-ref (list-ref grid row) (+ col 1)) -1))
                    -1
                    (loop (+ row 1) (+ col 1))))
               (else
                (if (or (< (- col 1) 0) (= (list-ref (list-ref grid row) (- col 1)) 1))
                    -1
                    (loop (+ row 1) (- col 1))))))))))))