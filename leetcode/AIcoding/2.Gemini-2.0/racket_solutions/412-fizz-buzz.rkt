(define (fizz-buzz n)
  (for/list ([i (in-range 1 (+ n 1))])
    (cond
      [(and (= (modulo i 3) 0) (= (modulo i 5) 0)) "FizzBuzz"]
      [(= (modulo i 3) 0) "Fizz"]
      [(= (modulo i 5) 0) "Buzz"]
      [else (number->string i)])))