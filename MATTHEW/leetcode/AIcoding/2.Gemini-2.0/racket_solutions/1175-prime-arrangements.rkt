(define (num-prime-arrangements n)
  (define (is-prime? n)
    (cond
      [(<= n 1) #f]
      [(= n 2) #t]
      [(even? n) #f]
      [else (let loop ([i 3])
              (cond
                [(> (* i i) n) #t]
                [(= (remainder n i) 0) #f]
                [else (loop (+ i 2))]))]))

  (define (count-primes n)
    (let loop ([i 1] [count 0])
      (if (> i n)
          count
          (loop (+ i 1) (if (is-prime? i) (+ count 1) count)))))

  (define (factorial n)
    (let loop ([i n] [acc 1])
      (if (= i 0)
          acc
          (loop (- i 1) (modulo (* acc i) 1000000007)))))

  (let ([num-primes (count-primes n)]
        [num-non-primes (- n num-primes)])
    (modulo (* (factorial num-primes) (factorial num-non-primes)) 1000000007)))