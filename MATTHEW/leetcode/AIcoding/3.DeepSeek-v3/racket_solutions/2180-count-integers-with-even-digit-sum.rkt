(define/contract (count-even num)
  (-> exact-integer? exact-integer?)
  (define (digit-sum n)
    (if (= n 0)
        0
        (+ (modulo n 10) (digit-sum (quotient n 10)))))
  (define (is-even-sum? n)
    (even? (digit-sum n)))
  (let loop ([i 1] [count 0])
    (if (> i num)
        count
        (loop (+ i 1) (if (is-even-sum? i) (+ count 1) count)))))