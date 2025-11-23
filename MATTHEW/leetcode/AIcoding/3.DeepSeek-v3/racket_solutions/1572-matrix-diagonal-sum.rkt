(define/contract (diagonal-sum mat)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([n (length mat)])
    (let loop ([i 0] [sum 0])
      (if (= i n)
          sum
          (let ([j (- n 1 i)])
            (loop (+ i 1) 
                  (+ sum 
                     (list-ref (list-ref mat i) i) 
                     (if (= i j) 0 (list-ref (list-ref mat i) j)))))))))