(define (equal-product-subsets nums)
  (define n (length nums))
  (define total-product (apply * nums))
  (if (= total-product 0)
      (if (member? 0 nums) #t #f)
      (let loop ((i 0) (product 1))
        (cond
          [(> i n) #f]
          [(= product (sqrt total-product)) #t]
          [else (or (loop (+ i 1) product)
                    (loop (+ i 1) (* product (list-ref nums i))))]))))