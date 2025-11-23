(define/contract (find-best-value arr target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-arr (sort arr <)]
         [n (length sorted-arr)]
         [prefix (make-vector (add1 n) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref sorted-arr i))))
    (let loop ([left 0]
               [right (list-ref sorted-arr (sub1 n))]
               [result 0]
               [diff +inf.0])
      (if (> left right)
          result
          (let* ([mid (quotient (+ left right) 2)]
                 [index (let search ([low 0] [high (sub1 n)])
                          (if (> low high)
                              low
                              (let ([m (quotient (+ low high) 2)])
                                (if (<= (list-ref sorted-arr m) mid)
                                    (search (add1 m) high)
                                    (search low (sub1 m)))))]
                 [sum (+ (* mid (- n index)) (vector-ref prefix index))])
                 [current-diff (abs (- sum target))])
            (cond
              [(< current-diff diff) (loop left right mid current-diff)]
              [(= current-diff diff) (loop left right (min mid result) diff)]
              [else (if (< sum target)
                        (loop (add1 mid) right result diff)
                        (loop left (sub1 mid) result diff))]))))))