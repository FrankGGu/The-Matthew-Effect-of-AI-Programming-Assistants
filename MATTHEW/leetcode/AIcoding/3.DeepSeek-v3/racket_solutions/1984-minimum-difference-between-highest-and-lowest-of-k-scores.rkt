(define/contract (minimum-difference nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [min-diff (for/fold ([min-diff +inf.0])
                            ([i (in-range 0 (- n k -1))])
                    (let ([current-diff (- (list-ref sorted-nums (+ i k -1)) (list-ref sorted-nums i))])
                      (if (< current-diff min-diff)
                          current-diff
                          min-diff)))])
    (if (= k 1) 0 min-diff)))