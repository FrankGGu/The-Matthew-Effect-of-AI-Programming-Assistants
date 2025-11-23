(define/contract (min-subarray-length nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [total (apply + nums)]
         [k (quotient target total)]
         [remaining (remainder target total)]
         [result (if (zero? remaining)
                   (* k n)
                   (let loop ([left 0] [sum 0] [min-len +inf.0])
                     (if (>= left n)
                         (if (= min-len +inf.0) 0 min-len)
                         (let inner ([right left] [sum sum] [min-len min-len])
                           (if (>= sum remaining)
                               (loop (add1 left) (- sum (list-ref nums left)) (min min-len (- right left)))
                               (if (>= right (* 2 n))
                                   (if (= min-len +inf.0) 0 min-len)
                                   (inner (add1 right) (+ sum (list-ref nums (modulo right n))) min-len))))))))])
    (if (zero? result) -1 result)))