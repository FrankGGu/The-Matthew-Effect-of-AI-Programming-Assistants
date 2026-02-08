(define (minimum-average-difference nums)
  (let* ([n (length nums)]
         [prefix-sums (make-vector (add1 n) 0)]
         [total-sum (apply + nums)])
    (for/fold ([i 0]
               [min-avg-diff (expt 10 9)]
               [min-index 0])
              ([num (in-list nums)]
               [index (in-range n)])
      (begin
        (vector-set! prefix-sums (add1 index) (+ (vector-ref prefix-sums index) num))
        (let* ([left-avg (quotient (vector-ref prefix-sums (add1 index)) (add1 index))]
               [right-avg (if (= index (- n 1))
                              0
                              (quotient (- total-sum (vector-ref prefix-sums (add1 index))) (- n (add1 index))))]
               [avg-diff (abs (- left-avg right-avg))])
          (if (< avg-diff min-avg-diff)
              (values (add1 i) avg-diff index)
              (values (add1 i) min-avg-diff min-index)))))))