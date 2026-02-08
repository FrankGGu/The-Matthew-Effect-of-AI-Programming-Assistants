(define/contract (find-gcd nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (gcd a b)
    (if (zero? b)
        a
        (gcd b (modulo a b))))
  (let* ([min-num (apply min nums)]
         [max-num (apply max nums)])
    (gcd min-num max-num)))