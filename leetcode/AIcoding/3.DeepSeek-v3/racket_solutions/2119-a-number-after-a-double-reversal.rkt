(define/contract (is-same-after-reversals num)
  (-> exact-integer? boolean?)
  (if (= num 0)
      #t
      (not (zero? (remainder num 10)))))