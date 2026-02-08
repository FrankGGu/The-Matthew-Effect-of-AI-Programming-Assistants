(define (search-matrix matrix target)
  (let* ((m (length matrix))
         (n (if (null? matrix) 0 (length (car matrix)))))
    (if (or (= m 0) (= n 0))
        #f
        (let loop ((row 0) (col (- n 1)))
          (cond
            ((or (>= row m) (< col 0)) #f)
            (else
             (let ((current-val (list-ref (list-ref matrix row) col)))
               (cond
                 ((= current-val target) #t)
                 ((< current-val target) (loop (+ row 1) col))
                 (else (loop row (- col 1)))))))))))