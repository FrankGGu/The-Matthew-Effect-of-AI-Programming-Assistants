(define (count-numbers-with-unique-digits n)
  (if (= n 0) 
      1
      (let loop ((count 10) (i 1) (unique-digits 9) (available 9))
        (if (= i n)
            count
            (loop (+ count (* unique-digits available))
                  (+ i 1)
                  (* unique-digits (- available 1))
                  (- available 1))))))

(define (countNumbersWithUniqueDigits n)
  (count-numbers-with-unique-digits n))