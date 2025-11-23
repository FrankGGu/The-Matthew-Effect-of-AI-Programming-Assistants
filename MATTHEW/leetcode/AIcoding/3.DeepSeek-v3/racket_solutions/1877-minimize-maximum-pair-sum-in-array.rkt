(define/contract (min-pair-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [max-sum 0])
    (for ([i (in-range (quotient n 2))])
      (set! max-sum (max max-sum (+ (list-ref sorted i) (list-ref sorted (- n 1 i))))))
    max-sum))