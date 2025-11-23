(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (is-good-array nums)
  (let loop ([nums nums] [current-gcd 0])
    (cond
      [(null? nums) (= current-gcd 1)]
      [(= current-gcd 1) #t]
      [else (loop (cdr nums) (gcd current-gcd (car nums)))])))