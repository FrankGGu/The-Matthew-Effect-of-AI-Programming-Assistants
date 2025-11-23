(define/contract (find-peak-element nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (= left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [next (add1 mid)])
          (if (> (list-ref nums mid) (list-ref nums next))
              (loop left mid)
              (loop next right))))))