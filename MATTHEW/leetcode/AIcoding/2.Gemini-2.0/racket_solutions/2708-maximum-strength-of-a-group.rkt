(define (max-strength nums)
  (let ([pos-nums (filter positive? nums)]
        [neg-nums (filter negative? nums)]
        [zeros (filter zero? nums)])
    (cond
      [(empty? nums) 0]
      [(and (empty? pos-nums) (empty? neg-nums)) 0]
      [(and (empty? pos-nums) (= (length neg-nums) 1)) (first neg-nums)]
      [else
       (let ([sorted-neg-nums (sort neg-nums >)])
         (let ([filtered-neg-nums (if (odd? (length sorted-neg-nums))
                                        (drop-right sorted-neg-nums 1)
                                        sorted-neg-nums)])
           (define (product lst)
             (if (empty? lst)
                 1
                 (* (first lst) (product (rest lst)))))
           (* (product pos-nums) (product filtered-neg-nums))))])))