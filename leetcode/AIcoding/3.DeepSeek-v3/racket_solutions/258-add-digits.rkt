(define/contract (add-digits num)
  (-> exact-integer? exact-integer?)
  (if (= num 0)
      0
      (let ([mod (modulo num 9)])
        (if (= mod 0) 9 mod))))