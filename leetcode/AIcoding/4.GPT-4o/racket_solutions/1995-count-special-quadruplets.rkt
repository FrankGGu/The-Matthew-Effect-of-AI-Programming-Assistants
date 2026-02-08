(define (countQuadruplets nums)
  (define n (length nums))
  (define count 0)
  (for ([i (in-range n)]
        [j (in-range (add1 i) n)]
        [k (in-range (add1 j) n)])
    (for ([l (in-range (add1 k) n)])
      (when (= (+ (list-ref nums i) (list-ref nums j) (list-ref nums k)) (list-ref nums l))
        (set! count (add1 count)))))
  count)