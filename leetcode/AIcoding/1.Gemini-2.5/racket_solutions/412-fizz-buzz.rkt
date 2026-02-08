(define (fizzbuzz n)
  (for/list ([i (in-range 1 (add1 n))])
    (cond
      [(and (= (remainder i 3) 0) (= (remainder i 5) 0)) "FizzBuzz"]
      [(= (remainder i 3) 0) "Fizz"]
      [(= (remainder i 5) 0) "Buzz"]
      [else (number->string i)])))