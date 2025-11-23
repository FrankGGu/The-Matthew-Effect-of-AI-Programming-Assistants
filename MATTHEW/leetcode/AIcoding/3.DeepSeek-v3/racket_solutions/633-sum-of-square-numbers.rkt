(define/contract (judge-square-sum c)
  (-> exact-integer? boolean?)
  (let loop ([a 0] [b (exact-integer-sqrt c)])
    (cond
      [(> (* a a) c) #f]
      [(= (+ (* a a) (* b b)) c) #t]
      [(< (+ (* a a) (* b b)) c) (loop (add1 a) b)]
      [else (loop a (sub1 b))])))