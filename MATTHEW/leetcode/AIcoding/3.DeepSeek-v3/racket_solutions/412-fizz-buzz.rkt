(define (fizz-buzz n)
  (define (helper i)
    (cond
      [(> i n) '()]
      [(and (= (modulo i 3) 0) (= (modulo i 5) 0)) (cons "FizzBuzz" (helper (+ i 1)))]
      [(= (modulo i 3) 0) (cons "Fizz" (helper (+ i 1)))]
      [(= (modulo i 5) 0) (cons "Buzz" (helper (+ i 1)))]
      [else (cons (number->string i) (helper (+ i 1)))]))
  (helper 1))