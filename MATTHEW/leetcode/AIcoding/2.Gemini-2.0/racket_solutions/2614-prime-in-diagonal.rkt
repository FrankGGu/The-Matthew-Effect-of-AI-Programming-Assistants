(define (prime? n)
  (cond
    [(<= n 1) #f]
    [(= n 2) #t]
    [(even? n) #f]
    [else
     (let loop ([i 3])
       (cond
         [(> (* i i) n) #t]
         [(= (remainder n i) 0) #f]
         [else (loop (+ i 2))]))]))

(define (diagonal-prime-product nums)
  (let ([n (vector-length nums)])
    (let loop ([i 0] [max-prime 0])
      (if (= i n)
          max-prime
          (let ([num1 (vector-ref (vector-ref nums i) i)]
                [num2 (vector-ref (vector-ref nums i) (- n 1 i))])
            (let ([p1 (if (prime? num1) num1 0)]
                  [p2 (if (and (!= i (- n 1 i)) (prime? num2)) num2 0)])
              (loop (+ i 1) (max max-prime p1 p2))))))))