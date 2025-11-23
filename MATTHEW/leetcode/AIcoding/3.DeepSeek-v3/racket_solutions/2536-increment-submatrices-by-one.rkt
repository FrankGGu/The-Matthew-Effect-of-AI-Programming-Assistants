(define/contract (range-add-queries n queries)
  (-> exact-integer? (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define mat (for/vector ([i n]) (make-vector n 0)))
  (for ([q queries])
    (let ([row1 (first q)]
          [col1 (second q)]
          [row2 (third q)]
          [col2 (fourth q)])
      (for ([i (in-range row1 (add1 row2))])
        (for ([j (in-range col1 (add1 col2))])
          (vector-set! (vector-ref mat i) j (add1 (vector-ref (vector-ref mat i) j)))))))
  (for/list ([i (in-range n)])
    (for/list ([j (in-range n)])
      (vector-ref (vector-ref mat i) j)))