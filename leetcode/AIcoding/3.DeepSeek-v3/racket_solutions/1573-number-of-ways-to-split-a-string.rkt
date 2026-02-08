(define/contract (num-ways s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define ones (for/sum ([c s]) (if (char=? c #\1) 1 0)))
  (if (not (zero? (modulo ones 3)))
      0
      (let* ([k (quotient ones 3)]
             [modulus 1000000007]
             [count1 0]
             [count2 0]
             [current 0]
             [result 0])
        (for ([c s] [i (in-range n)])
          (when (char=? c #\1)
            (set! current (add1 current)))
          (when (and (= current k) (< i (sub1 n)))
            (set! count1 (add1 count1)))
          (when (and (= current (* 2 k)) (< i (sub1 n)))
            (set! count2 (add1 count2)))
        (if (zero? k)
            (modulo (quotient (* (sub1 n) (sub1 (sub1 n))) 2) modulus)
            (modulo (* count1 count2) modulus)))))