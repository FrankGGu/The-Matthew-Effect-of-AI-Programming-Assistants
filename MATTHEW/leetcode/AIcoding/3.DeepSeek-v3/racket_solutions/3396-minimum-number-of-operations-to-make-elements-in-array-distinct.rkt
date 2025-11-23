(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)]
             [prev -inf.0]
             [ops 0])
    (if (null? nums)
        ops
        (let ([current (car nums)])
          (if (> current prev)
              (loop (cdr nums) current ops)
              (loop (cdr nums) (add1 prev) (+ ops (- (add1 prev) current)))))))