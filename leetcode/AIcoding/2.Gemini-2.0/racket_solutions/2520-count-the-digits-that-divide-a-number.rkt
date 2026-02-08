(define (count-digits-that-divide-number num)
  (let loop ([n num] [count 0])
    (if (= n 0)
        count
        (let ([digit (modulo n 10)])
          (if (and (not (= digit 0)) (= (modulo num digit) 0))
              (loop (quotient n 10) (+ count 1))
              (loop (quotient n 10) count))))))