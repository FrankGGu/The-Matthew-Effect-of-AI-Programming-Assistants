(define/contract (sum-indices-with-k-set-bits nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (count-bits n)
    (if (zero? n)
        0
        (+ (bitwise-and n 1) (count-bits (arithmetic-shift n -1)))))
  (let loop ([i 0] [sum 0])
    (if (>= i (length nums))
        sum
        (if (= (count-bits i) k)
            (loop (+ i 1) (+ sum (list-ref nums i)))
            (loop (+ i 1) sum)))))