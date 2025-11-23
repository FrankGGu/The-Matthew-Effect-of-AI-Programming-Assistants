(define/contract (search-matrix matrix target)
  (-> (listof (listof exact-integer?)) exact-integer? boolean?)
  (if (null? matrix)
      #f
      (let* ([rows (length matrix)]
             [cols (length (car matrix))]
             [left 0]
             [right (- (* rows cols) 1)])
        (let loop ([left left] [right right])
          (if (> left right)
              #f
              (let* ([mid (quotient (+ left right) 2)]
                     [row (quotient mid cols)]
                     [col (remainder mid cols)]
                     [val (list-ref (list-ref matrix row) col)])
                (cond
                  [(= val target) #t]
                  [(< val target) (loop (+ mid 1) right)]
                  [else (loop left (- mid 1))])))))))