(define (setZeroes matrix)
  (define rows (length matrix))
  (define cols (if (zero? rows) 0 (length (vector-ref matrix 0))))
  (define row-zeroes (make-vector rows #f))
  (define col-zeroes (make-vector cols #f))

  (for* ([i (in-range rows)]
         [j (in-range cols)])
    (when (= (vector-ref (vector-ref matrix i) j) 0)
      (vector-set! row-zeroes i #t)
      (vector-set! col-zeroes j #t)))

  (for* ([i (in-range rows)]
         [j (in-range cols)])
    (when (or (vector-ref row-zeroes i)
              (vector-ref col-zeroes j))
      (vector-set! (vector-ref matrix i) j 0)))

  matrix)