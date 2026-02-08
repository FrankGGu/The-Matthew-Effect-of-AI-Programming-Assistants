(define/contract (count-bits n)
  (-> exact-integer? (listof exact-integer?))
  (define (count-ones x)
    (if (= x 0)
        0
        (+ (bitwise-and x 1) (count-ones (arithmetic-shift x -1)))))
  (map count-ones (range (+ n 1))))