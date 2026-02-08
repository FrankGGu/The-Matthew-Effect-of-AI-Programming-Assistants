(define (canPartition nums)
  (define total (apply + nums))
  (if (odd? total) #f
      (define target (/ total 2))
      (define dp (make-vector (+ target 1) #f))
      (vector-set! dp 0 #t)
      (for-each
       (lambda (num)
         (for ([j (in-range target (sub1 num) -1)])
           (when (vector-ref dp j)
             (vector-set! dp (+ j num) #t))))
       nums)
      (vector-ref dp target)))

(define (canPartition nums)
  (canPartition nums))