(define/contract (smallest-range-II nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [ans (- (last sorted-nums) (first sorted-nums))])
    (for ([i (in-range (- n 1))])
      (let* ([a (list-ref sorted-nums i)]
             [b (list-ref sorted-nums (+ i 1))]
             [high (max (+ (last sorted-nums) (- k)) (+ a k))]
             [low (min (+ (first sorted-nums) k) (+ b (- k)))])
        (set! ans (min ans (- high low)))))
    ans))