(define/contract (minimum-removal beans)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-beans (sort beans <)]
         [n (length sorted-beans)]
         [prefix-sum (make-vector n 0)])
    (vector-set! prefix-sum 0 (list-ref sorted-beans 0))
    (for ([i (in-range 1 n)])
      (vector-set! prefix-sum i (+ (vector-ref prefix-sum (- i 1)) (list-ref sorted-beans i))))
    (let loop ([i 0]
               [min-beans +inf.0])
      (if (= i n)
          min-beans
          (let* ([sum-before (if (= i 0) 0 (vector-ref prefix-sum (- i 1)))]
                 [sum-after (if (= i (- n 1)) 0 (- (vector-ref prefix-sum (- n 1)) (vector-ref prefix-sum i)))]
                 [total (+ sum-before sum-after)])
            (loop (+ i 1) (min min-beans total)))))))