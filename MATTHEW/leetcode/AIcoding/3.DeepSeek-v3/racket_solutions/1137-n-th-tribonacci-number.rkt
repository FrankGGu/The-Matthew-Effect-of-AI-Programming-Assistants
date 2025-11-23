(define/contract (tribonacci n)
  (-> exact-integer? exact-integer?)
  (cond
    [(= n 0) 0]
    [(= n 1) 1]
    [(= n 2) 1]
    [else (let loop ([a 0] [b 1] [c 1] [k 3])
            (if (= k n)
                (+ a b c)
                (loop b c (+ a b c) (+ k 1))))]))