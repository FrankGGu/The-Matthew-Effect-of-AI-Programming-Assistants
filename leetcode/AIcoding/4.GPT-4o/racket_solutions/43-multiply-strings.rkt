(define (multiply-strings num1 num2)
  (if (or (string=? num1 "0") (string=? num2 "0"))
      "0"
      (let loop ((n1 (string->number num1))
                 (n2 (string->number num2))
                 (result 0))
        (if (= n2 0)
            (number->string result)
            (loop n1 (quotient n2 10) (+ result (* (modulo n2 10) n1)))))))

(multiply-strings "123" "456")