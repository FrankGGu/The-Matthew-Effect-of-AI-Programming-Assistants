(define/contract (get-subarray-beauty nums k x)
  (-> (listof exact-integer?) exact-integer? exact-integer? (listof exact-integer?))
  (let loop ([i 0] [result '()])
    (if (> (+ i k) (length nums))
        (reverse result)
        (let* ([sub (take (drop nums i) k)]
               [sorted (sort sub <)]
               [xth (list-ref sorted (sub1 x))])
          (loop (add1 i) (cons (if (< xth 0) xth 0) result))))))