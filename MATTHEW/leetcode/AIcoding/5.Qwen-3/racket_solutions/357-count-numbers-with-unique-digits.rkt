(define (count-numbers-with-unique-digits n)
  (if (> n 10) 0
      (let loop ([n n] [result 1] [current 9])
        (if (= n 0) result
            (loop (- n 1) (+ result current) (* current (- 10 n)))))))