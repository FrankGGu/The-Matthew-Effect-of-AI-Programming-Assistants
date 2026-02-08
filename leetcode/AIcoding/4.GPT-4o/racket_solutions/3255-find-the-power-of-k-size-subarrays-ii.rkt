(define (countSubarrays nums k)
  (define (count-power-sum subarray)
    (if (null? subarray)
        0
        (if (= (apply + subarray) k)
            (+ 1 (count-power-sum (cdr subarray)))
            (count-power-sum (cdr subarray)))))
  (define (count-all-subarrays lst)
    (if (null? lst)
        0
        (+ (count-power-sum (take lst (length lst)))
           (count-all-subarrays (cdr lst)))))
  (count-all-subarrays nums))

(define (find-the-power-of-k-size-subarrays-ii nums k)
  (countSubarrays nums k))