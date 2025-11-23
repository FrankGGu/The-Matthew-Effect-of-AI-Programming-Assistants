(define/contract (max-manhattan-distance nums k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [x (make-vector n 0)]
         [y (make-vector n 0)]
         [sum-x 0]
         [sum-y 0])
    (for ([i (in-range n)])
      (let ([xi (list-ref (list-ref nums i) 0)]
            [yi (list-ref (list-ref nums i) 1)])
        (vector-set! x i xi)
        (vector-set! y i yi)
        (set! sum-x (+ sum-x xi))
        (set! sum-y (+ sum-y yi))))
    (let ([x-sorted (sort (vector->list x) <)]
          [y-sorted (sort (vector->list y) <)])
      (let ([median-x (list-ref x-sorted (quotient n 2))]
            [median-y (list-ref y-sorted (quotient n 2))])
        (let loop ([i 0]
                   [k k]
                   [res 0])
          (if (or (>= i n) (<= k 0))
              res
              (let* ([xi (vector-ref x i)]
                     [yi (vector-ref y i)]
                     [dx (- median-x xi)]
                     [dy (- median-y yi)]
                     [delta (+ (abs dx) (abs dy))])
                (if (> delta 0)
                    (loop (+ i 1) (- k 1) (+ res delta))
                    (loop (+ i 1) k res)))))))))