(define (min-sum nums1 nums2)
  (define (calculate-sum nums)
    (for/fold ([sum 0] [zeros 0])
              ([num (in-list nums)])
      (if (= num 0)
          (values sum (+ zeros 1))
          (values (+ sum num) zeros))))

  (define-values (sum1 zeros1) (calculate-sum nums1))
  (define-values (sum2 zeros2) (calculate-sum nums2))

  (cond
    [(and (= zeros1 0) (= zeros2 0))
     (if (= sum1 sum2) sum1 -1)]
    [(= zeros1 0)
     (if (>= sum1 (+ sum2 zeros2)) sum1 -1)]
    [(= zeros2 0)
     (if (>= sum2 (+ sum1 zeros1)) sum2 -1)]
    [(> (+ sum1 zeros1) (+ sum2 zeros2))
     (+ sum1 zeros1)]
    [else
     (+ sum2 zeros2)]))