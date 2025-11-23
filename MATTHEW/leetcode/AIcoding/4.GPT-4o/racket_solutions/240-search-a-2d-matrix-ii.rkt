(define (searchMatrix matrix target)
  (define (search row col)
    (cond
      ((or (< row 0) (>= row (length matrix)) (< col 0) (>= col (length (vector-ref matrix row))))) #f)
      ((= (vector-ref (vector-ref matrix row) col) target) #t)
      ((< (vector-ref (vector-ref matrix row) col) target) (search (+ row 1) col))
      (else (search row (- col 1)))))
  (if (null? matrix) #f
      (search 0 (- (length (vector-ref matrix 0)) 1))))