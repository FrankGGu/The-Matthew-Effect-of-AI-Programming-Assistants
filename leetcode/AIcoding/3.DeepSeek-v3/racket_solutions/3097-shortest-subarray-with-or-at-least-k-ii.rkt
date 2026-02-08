(define/contract (shortest-subarray-or nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 0] [j 0] [current 0] [min-len +inf.0] [n (length nums)])
    (cond
      [(>= j n) (if (= min-len +inf.0) -1 min-len)]
      [else
       (let* ([new-current (bitwise-ior current (list-ref nums j))]
              [new-min-len (if (>= new-current k) (min min-len (- j i -1)) min-len)])
         (if (>= new-current k)
             (loop (add1 i) i 0 new-min-len n)
             (loop i (add1 j) new-current new-min-len n)))])))