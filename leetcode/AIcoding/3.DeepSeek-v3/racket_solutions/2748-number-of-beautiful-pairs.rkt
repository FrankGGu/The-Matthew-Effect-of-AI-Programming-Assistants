(define/contract (count-beautiful-pairs nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (gcd a b)
    (if (zero? b) a (gcd b (modulo a b))))
  (let loop ([i 0] [count 0])
    (if (>= i (length nums))
        count
        (let loop2 ([j (add1 i)] [current-count count])
          (if (>= j (length nums))
              (loop (add1 i) current-count)
              (let* ([x (list-ref nums i)]
                     [y (list-ref nums j)]
                     [first-digit (string->number (substring (number->string x) 0 1))]
                     [last-digit (modulo y 10)])
                (if (= (gcd first-digit last-digit) 1)
                    (loop2 (add1 j) (add1 current-count))
                    (loop2 (add1 j) current-count))))))))