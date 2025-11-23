(define (can-partition nums)
  (let* ([total-sum (foldl + 0 nums)])
    (if (odd? total-sum)
        #f
        (let* ([target (/ total-sum 2)]
               [dp (make-vector (+ target 1) #f)])
          (vector-set! dp 0 #t)

          (for-each (lambda (num)
                      (for ([j (in-range target (sub1 num) -1)])
                        (when (vector-ref dp (- j num))
                          (vector-set! dp j #t))))
                    nums)
          (vector-ref dp target)))))