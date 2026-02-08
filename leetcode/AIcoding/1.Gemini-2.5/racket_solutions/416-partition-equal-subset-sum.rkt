(define (can-partition nums)
  (let* ([total-sum (apply + nums)])
    (if (odd? total-sum)
        #f
        (let* ([target-sum (/ total-sum 2)]
               [dp (make-vector (+ target-sum 1) #f)])
          (vector-set! dp 0 #t) ; Base case: sum 0 is always possible

          (for-each (lambda (num)
                      ; Iterate downwards to avoid using the same number multiple times in a single pass
                      (for ([j (in-range target-sum (sub1 num) -1)])
                        (when (vector-ref dp (- j num))
                          (vector-set! dp j #t))))
                    nums)
          (vector-ref dp target-sum)))))