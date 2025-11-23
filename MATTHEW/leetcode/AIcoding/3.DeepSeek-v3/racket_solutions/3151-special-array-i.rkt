(define/contract (is-array-special nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([i 0])
    (if (>= i (sub1 (length nums)))
        #t
        (let ([parity1 (bitwise-and (list-ref nums i) 1)]
              [parity2 (bitwise-and (list-ref nums (add1 i)) 1)])
          (if (= parity1 parity2)
              #f
              (loop (add1 i))))))