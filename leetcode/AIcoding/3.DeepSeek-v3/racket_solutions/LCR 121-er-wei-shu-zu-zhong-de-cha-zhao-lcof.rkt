(define/contract (search-matrix matrix target)
  (-> (listof (listof exact-integer?)) exact-integer? boolean?)
  (if (null? matrix)
      #f
      (let ([m (length matrix)]
            [n (length (car matrix))])
        (let loop ([left 0]
                   [right (- (* m n) 1)])
          (if (> left right)
              #f
              (let* ([mid (quotient (+ left right) 2)]
                     [row (quotient mid n)]
                     [col (remainder mid n)]
                     [val (list-ref (list-ref matrix row) col)])
                (cond
                  [(= val target) #t]
                  [(< val target) (loop (+ mid 1) right)]
                  [else (loop left (- mid 1))])))))))