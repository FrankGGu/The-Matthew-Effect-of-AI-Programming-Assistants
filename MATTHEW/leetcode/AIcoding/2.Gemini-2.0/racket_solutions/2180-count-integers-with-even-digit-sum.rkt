(define (digit-sum n)
  (if (= n 0)
      0
      (+ (remainder n 10) (digit-sum (quotient n 10)))))

(define (count-even-digit-sum n)
  (let loop ([i 1] [count 0])
    (if (> i n)
        count
        (if (even? (digit-sum i))
            (loop (+ i 1) (+ count 1))
            (loop (+ i 1) count)))))