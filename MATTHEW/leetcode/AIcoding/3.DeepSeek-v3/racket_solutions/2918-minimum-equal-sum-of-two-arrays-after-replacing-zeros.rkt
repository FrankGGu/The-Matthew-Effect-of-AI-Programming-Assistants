(define (min-sum nums1 nums2)
  (define (sum-and-count-zero nums)
    (let loop ([nums nums] [s 0] [zeros 0])
      (if (null? nums)
          (cons s zeros)
          (loop (cdr nums) (+ s (max 1 (car nums))) (if (= (car nums) 0) (+ zeros 1) zeros)))))

  (let* ([res1 (sum-and-count-zero nums1)]
         [res2 (sum-and-count-zero nums2)]
         [sum1 (car res1)]
         [zeros1 (cdr res1)]
         [sum2 (car res2)]
         [zeros2 (cdr res2)])
    (cond
      [(and (= zeros1 0) (= zeros2 0)) (if (= sum1 sum2) sum1 -1)]
      [(= zeros1 0) (if (>= sum1 sum2) sum1 -1)]
      [(= zeros2 0) (if (>= sum2 sum1) sum2 -1)]
      [else (let ([min-sum (max sum1 sum2)])
              (if (<= min-sum (min (+ sum1 zeros1) (+ sum2 zeros2))) min-sum -1))])))