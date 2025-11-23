(define/contract (partition-array nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [result 1]
         [start (car sorted-nums)])
    (for ([i (in-range 1 n)])
      (let ([current (list-ref sorted-nums i)])
        (when (> (- current start) k)
          (set! result (add1 result))
          (set! start current))))
    result))