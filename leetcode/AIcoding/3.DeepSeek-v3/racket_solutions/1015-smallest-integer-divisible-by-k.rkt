(define/contract (smallest-repunit-div-by-k k)
  (-> exact-integer? exact-integer?)
  (if (or (zero? (modulo k 2)) (zero? (modulo k 5)))
      -1
      (let loop ([remainder 0] [length 1])
        (let* ([new-remainder (modulo (+ (* 10 remainder) 1) k)]
               [found (zero? new-remainder)])
          (if found
              length
              (loop new-remainder (add1 length))))))