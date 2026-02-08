(define/contract (smallest-divisor nums threshold)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (sum-divisors d)
    (for/sum ([num (in-list nums)])
      (ceiling (/ num d))))

  (let loop ([left 1] [right (apply max nums)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (> (sum-divisors mid) threshold)
              (loop (+ mid 1) right)
              (loop left mid)))))