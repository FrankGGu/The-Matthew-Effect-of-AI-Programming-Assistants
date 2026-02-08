(define (searchMatrix matrix target)
  (if (or (null? matrix) (null? (car matrix)))
      #f
      (let loop ((row 0) (col (sub1 (length (car matrix)))))
        (cond
          ((>= row (length matrix)) #f)
          ((< (list-ref (list-ref matrix row) col) target)
           (loop (add1 row) col))
          ((> (list-ref (list-ref matrix row) col) target)
           (loop row (sub1 col)))
          (else #t)))))