(define/contract (count-square-sum-triples n)
  (-> exact-integer? exact-integer?)
  (define count 0)
  (for* ([a (in-range 1 (add1 n))]
         [b (in-range 1 (add1 n))]
         [c (in-range 1 (add1 n))])
    (when (= (+ (* a a) (* b b)) (* c c))
      (set! count (add1 count))))
  count)