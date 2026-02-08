(define (palindrome-number x)
  (cond
    [(< x 0) #f]
    [(and (> x 0) (= (remainder x 10) 0)) #f]
    [else
     (let loop ((num x) (reverted-num 0))
       (if (<= num reverted-num)
           (or (= num reverted-num) (= num (quotient reverted-num 10)))
           (loop (quotient num 10)
                 (+ (* reverted-num 10) (remainder num 10)))))
     ]))