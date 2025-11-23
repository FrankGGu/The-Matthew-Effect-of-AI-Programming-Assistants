(define/contract (longest-subsequence s k)
  (-> string? exact-integer? exact-integer?)
  (let loop ([i (sub1 (string-length s))]
              [len 0]
              [sum 0]
              [pow 1])
    (cond
      [(< i 0) len]
      [(> (* pow 2) k) (loop (sub1 i) len sum pow)]
      [else
       (let* ([c (string-ref s i)]
              [val (if (char=? c #\1) pow 0)]
              [new-sum (+ sum val)])
         (if (> new-sum k)
             (loop (sub1 i) len sum pow)
             (loop (sub1 i) (add1 len) new-sum (* pow 2))))])))