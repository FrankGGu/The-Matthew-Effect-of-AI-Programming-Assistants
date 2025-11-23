(define/contract (minimum-deletions nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([min-val (apply min nums)]
         [max-val (apply max nums)]
         [min-idx (index-of nums min-val)]
         [max-idx (index-of nums max-val)]
         [n (length nums)]
         [i (min min-idx max-idx)]
         [j (max min-idx max-idx)])
    (min (+ j 1)
         (- n i)
         (+ (- n j) i 1))))