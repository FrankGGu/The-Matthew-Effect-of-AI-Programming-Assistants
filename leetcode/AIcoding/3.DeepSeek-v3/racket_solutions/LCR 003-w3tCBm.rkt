(define/contract (count-bits n)
  (-> exact-integer? (listof exact-integer?))
  (for/list ([i (in-range (+ n 1))])
    (let loop ([num i] [count 0])
      (if (zero? num)
          count
          (loop (arithmetic-shift num -1) (+ count (bitwise-and num 1)))))))