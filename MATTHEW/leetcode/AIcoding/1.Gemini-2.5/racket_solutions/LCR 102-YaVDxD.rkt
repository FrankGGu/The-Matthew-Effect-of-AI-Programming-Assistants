(define (find-target-sum-ways nums target)
  (let* ([s-total (apply + nums)])
    (if (or (< (+ target s-total) 0)
            (odd? (+ target s-total)))
        0
        (let* ([target-sum-for-subset (quotient (+ target s-total) 2)]
               [dp (make-vector (+ target-sum-for-subset 1) 0)])
          (vector-set! dp 0 1)
          (for-each (lambda (num)
                      (for ([s (in-range target-sum-for-subset (- num 1) -1)])
                        (vector-set! dp s (+ (vector-ref dp s) (vector-ref dp (- s num))))))
                    nums)
          (vector-ref dp target-sum-for-subset)))))