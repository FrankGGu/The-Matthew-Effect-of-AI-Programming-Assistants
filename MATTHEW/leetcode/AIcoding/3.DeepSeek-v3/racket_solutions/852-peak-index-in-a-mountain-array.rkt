(define/contract (peak-index-in-mountain-array arr)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (- (length arr) 1)])
    (let* ([mid (quotient (+ left right) 2)]
           [mid-val (list-ref arr mid)]
           [next-val (list-ref arr (+ mid 1))])
      (cond
        [(< mid-val next-val) (loop (+ mid 1) right)]
        [(> mid-val next-val) (loop left mid)]
        [else mid]))))