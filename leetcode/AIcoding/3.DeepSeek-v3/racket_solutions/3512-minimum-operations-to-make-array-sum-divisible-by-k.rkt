(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([total (foldl + 0 nums)]
         [remainder (modulo total k)])
    (if (zero? remainder)
        0
        (let ([target (- k remainder)])
          (let loop ([nums nums] [count 0])
            (cond
              [(null? nums) -1]
              [(= (modulo (car nums) k) target) (add1 count)]
              [else (loop (cdr nums) (add1 count))]))))))