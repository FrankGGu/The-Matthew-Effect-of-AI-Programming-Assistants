(define/contract (single-non-duplicate nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (>= left right)
        (list-ref nums left)
        (let* ([mid (quotient (+ left right) 2)]
               [mid-even? (even? mid)]
               [mid-val (list-ref nums mid)]
               [next-val (list-ref nums (add1 mid))])
          (if (or (and mid-even? (= mid-val next-val))
                  (and (not mid-even?) (not (= mid-val next-val))))
              (loop (add1 mid) right)
              (loop left mid))))))