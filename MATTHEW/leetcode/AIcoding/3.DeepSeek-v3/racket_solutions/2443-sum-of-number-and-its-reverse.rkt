(define/contract (sum-of-number-and-reverse num)
  (-> exact-integer? boolean?)
  (define (reverse-number n)
    (let loop ([n n] [rev 0])
      (if (= n 0)
          rev
          (loop (quotient n 10) (+ (* rev 10) (remainder n 10))))))
  (for/or ([k (in-range 0 (+ num 1))])
    (= num (+ k (reverse-number k)))))