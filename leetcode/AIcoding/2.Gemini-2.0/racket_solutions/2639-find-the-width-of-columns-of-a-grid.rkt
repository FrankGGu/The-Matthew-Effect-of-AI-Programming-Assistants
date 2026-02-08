(define (find-column-width grid)
  (if (null? grid)
      '()
      (let* ([num-cols (length (car grid))]
             [widths (make-vector num-cols 0)])
        (for* ([row grid]
               [col (in-range num-cols)])
          (vector-set! widths col (max (vector-ref widths col) (string-length (number->string (list-ref row col))))))
        (vector->list widths))))