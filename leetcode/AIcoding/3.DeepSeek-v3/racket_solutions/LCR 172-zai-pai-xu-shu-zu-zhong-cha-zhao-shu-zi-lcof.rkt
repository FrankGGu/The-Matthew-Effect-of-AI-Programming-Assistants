(define/contract (search nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0]
             [right (sub1 (length nums))]
             [first-pos -1]
             [last-pos -1])
    (cond
      [(> left right) (if (= first-pos -1) 0 (add1 (- last-pos first-pos)))]
      [else
       (define mid (quotient (+ left right) 2))
       (define mid-val (list-ref nums mid))
       (cond
         [(< mid-val target) (loop (add1 mid) right first-pos last-pos)]
         [(> mid-val target) (loop left (sub1 mid) first-pos last-pos)]
         [else
          (define new-first (if (= first-pos -1) mid (min first-pos mid)))
          (define new-last (max last-pos mid))
          (loop left (sub1 mid) new-first new-last)
          (loop (add1 mid) right new-first new-last)])]))))