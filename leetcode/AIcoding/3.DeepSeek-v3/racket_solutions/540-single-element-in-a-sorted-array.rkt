(define/contract (single-non-duplicate nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (>= left right)
        (list-ref nums left)
        (let* ([mid (quotient (+ left right) 2)]
               [half (- mid left)]
               [even? (even? half)])
          (if (if even?
                   (= (list-ref nums mid) (list-ref nums (add1 mid)))
                   (not (= (list-ref nums mid) (list-ref nums (sub1 mid))))
              (loop (add1 mid) right)
              (loop left mid))))))