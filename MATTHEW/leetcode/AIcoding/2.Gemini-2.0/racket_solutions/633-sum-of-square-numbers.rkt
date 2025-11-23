(define (judge-square-sum c)
  (let loop ([a 0] [b (integer-sqrt c)])
    (cond
      [(> a b) #f]
      [(= (+ (* a a) (* b b)) c) #t]
      [(< (+ (* a a) (* b b)) c) (loop (+ a 1) b)]
      [else (loop a (- b 1))])))