(define (split-array nums k)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [total-sum (foldl + 0 nums)]
         [max-val (if (null? nums) 0 (apply max nums))])

    (define (count-subarrays limit)
      (let loop ([idx 0]
                 [current-sum 0]
                 [num-splits 1])
        (if (= idx n)
            num-splits
            (let ([val (vector-ref nums-vec idx)])
              (if (> val limit)
                  #f
                  (if (<= (+ current-sum val) limit)
                      (loop (+ idx 1) (+ current-sum val) num-splits)
                      (loop (+ idx 1) val (+ num-splits 1))))))))

    (let binary-search ([low max-val]
                        [high total-sum]
                        [ans total-sum])
      (if (> low high)
          ans
          (let ([mid (+ low (quotient (- high low) 2))])
            (let ([required-splits (count-subarrays mid)])
              (if (and required-splits (<= required-splits k))
                  (binary-search low (- mid 1) mid)
                  (binary-search (+ mid 1) high ans))))))))