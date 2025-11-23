(define/contract (search-matrix matrix target)
  (-> (listof (listof exact-integer?)) exact-integer? boolean?)
  (if (null? matrix)
      #f
      (let ([rows (length matrix)]
            [cols (length (car matrix))])
        (let loop ([row 0]
                   [col (sub1 cols)])
          (cond
            [(or (>= row rows) (< col 0)) #f]
            [(= (list-ref (list-ref matrix row) col) target) #t]
            [(< (list-ref (list-ref matrix row) col) target) (loop (add1 row) col)]
            [else (loop row (sub1 col))])))))