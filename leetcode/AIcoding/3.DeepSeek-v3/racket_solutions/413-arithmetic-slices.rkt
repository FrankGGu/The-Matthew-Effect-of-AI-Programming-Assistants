(define/contract (number-of-arithmetic-slices nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 2] [count 0] [total 0] [nums nums])
    (cond
      [(>= i (length nums)) total]
      [(= (- (list-ref nums i) (list-ref nums (sub1 i)))
          (- (list-ref nums (sub1 i)) (list-ref nums (- i 2))))
       (loop (add1 i) (add1 count) (+ total count) nums)]
      [else
       (loop (add1 i) 0 total nums)])))