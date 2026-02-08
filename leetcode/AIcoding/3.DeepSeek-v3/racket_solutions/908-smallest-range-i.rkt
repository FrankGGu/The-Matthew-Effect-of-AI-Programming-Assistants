(define/contract (smallest-range-i nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([min-num (apply min nums)]
         [max-num (apply max nums)]
         [diff (- max-num min-num)])
    (if (<= diff (* 2 k))
        0
        (- diff (* 2 k)))))