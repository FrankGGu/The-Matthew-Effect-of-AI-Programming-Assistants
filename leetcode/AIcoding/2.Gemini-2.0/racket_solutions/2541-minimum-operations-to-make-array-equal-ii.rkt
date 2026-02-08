(define (minOperations nums1 nums2 k)
  (let* ((n (length nums1))
         (diffs (map - nums1 nums2))
         (pos-sum 0)
         (neg-sum 0))
    (for ([diff diffs])
      (cond
        [(> diff 0) (set! pos-sum (+ pos-sum diff))]
        [(< diff 0) (set! neg-sum (+ neg-sum (- diff)))]))
    (if (or (not (= pos-sum neg-sum))
            (zero? k))
        (if (and (zero? pos-sum) (zero? neg-sum))
            0
            -1)
        (if (zero? k)
            (if (and (zero? pos-sum) (zero? neg-sum))
                0
                -1)
            (let loop ([diffs diffs])
              (cond
                [(empty? diffs)
                 (if (and (= pos-sum neg-sum)
                          (= (modulo pos-sum k) 0))
                     (/ pos-sum k)
                     -1)]
                [else
                 (let ([diff (car diffs)])
                   (if (and (not (zero? diff))
                            (not (zero? k))
                            (not (= (modulo diff k) 0)))
                       -1
                       (loop (cdr diffs))))]))))))