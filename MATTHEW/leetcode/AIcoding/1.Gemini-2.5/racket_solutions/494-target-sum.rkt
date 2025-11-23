(define (find-target-sum-ways nums S)
  (let* ([num-zeros (count (lambda (x) (= x 0)) nums)]
         [non-zero-nums (filter (lambda (x) (> x 0)) nums)]
         [total-sum-non-zero (if (empty? non-zero-nums)
                                 0
                                 (apply + non-zero-nums))]
         [required-sum-for-P (+ S total-sum-non-zero)])

    (if (or (< required-sum-for-P 0)
            (odd? required-sum-for-P))
        0
        (let* ([target-subset-sum (/ required-sum-for-P 2)]
               [dp (make-vector (+ target-subset-sum 1) 0)])

          (vector-set! dp 0 1)

          (for-each (lambda (num)
                      (for ([j (in-range target-subset-sum (- num 1) -1)])
                        (vector-set! dp j
                                     (+ (vector-ref dp j)
                                        (vector-ref dp (- j num))))))
                    non-zero-nums)

          (* (vector-ref dp target-subset-sum)
             (expt 2 num-zeros))))))