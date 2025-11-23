(define/contract (is-good-array nums)
  (-> (listof exact-integer?) boolean?)
  (define (gcd a b)
    (if (zero? b) a (gcd b (modulo a b))))
  (let loop ([current-gcd (car nums)] [rest (cdr nums)])
    (cond
      [(null? rest) (= 1 current-gcd)]
      [(= 1 current-gcd) #t]
      [else (loop (gcd current-gcd (car rest)) (cdr rest))])))