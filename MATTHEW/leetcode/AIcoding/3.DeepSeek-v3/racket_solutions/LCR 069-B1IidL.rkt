(define/contract (peak-index-in-mountain-array arr)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (- (length arr) 1)])
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (> (list-ref arr mid) (list-ref arr (+ mid 1)))
              (loop left mid)
              (loop (+ mid 1) right))))))