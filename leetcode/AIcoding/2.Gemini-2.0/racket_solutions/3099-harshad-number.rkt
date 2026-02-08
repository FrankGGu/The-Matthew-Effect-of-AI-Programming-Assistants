(define (harshad-number? n)
  (define (sum-digits n)
    (if (= n 0)
        0
        (+ (remainder n 10) (sum-digits (quotient n 10)))))
  (if (= n 0)
      #f
      (let ((sum (sum-digits n)))
        (if (= sum 0)
            #f
            (= (remainder n sum) 0)))))

(define (solve n)
  (harshad-number? n))