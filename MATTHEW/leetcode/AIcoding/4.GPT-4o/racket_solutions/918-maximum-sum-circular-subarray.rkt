(define (max-sum-circular-subarray nums)
  (define (kadane arr)
    (define max-so-far (car arr))
    (define max-ending-here (car arr))
    (for ([x (cdr arr)])
      (set! max-ending-here (max x (+ max-ending-here x)))
      (set! max-so-far (max max-so-far max-ending-here)))
    max-so-far)

  (define total (apply + nums))
  (define max-kadane (kadane nums))
  (define min-kadane (kadane (map - nums)))
  (define max-wrap (total + min-kadane))

  (max max-kadane max-wrap))

(max-sum-circular-subarray '(1 -2 3 -2))