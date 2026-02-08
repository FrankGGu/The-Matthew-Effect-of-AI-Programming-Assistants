(define (transpose matrix)
  (let* ([rows (length matrix)]
         [cols (length (car matrix))]
         [transposed (make-vector cols (make-vector rows #f))])
    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (vector-set! (vector-ref transposed j) i (list-ref (list-ref matrix i) j))))
    (map vector->list (vector->list transposed))))