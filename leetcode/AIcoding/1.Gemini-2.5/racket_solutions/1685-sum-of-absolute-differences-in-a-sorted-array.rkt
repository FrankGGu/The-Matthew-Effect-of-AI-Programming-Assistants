(define (sum-of-absolute-differences nums)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [prefix-sums (make-vector (+ n 1) 0)])

    ;; Calculate prefix sums
    (for ([i (in-range n)])
      (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums-vec i))))

    ;; Calculate result for each element
    (for/list ([i (in-range n)])
      (let* ([num-i (vector-ref nums-vec i)]
             [left-sum (vector-ref prefix-sums i)]
             [left-count i]
             [right-sum (- (vector-ref prefix-sums n) (vector-ref prefix-sums (+ i 1)))]
             [right-count (- n 1 i)])

        ;; Sum of absolute differences:
        ;; (sum(nums[i] - nums[j]) for j < i) + (sum(nums[j] - nums[i]) for j > i)
        ;; = (left_count * nums[i] - left_sum) + (right_sum - right_count * nums[i])
        (+ (* left-count num-i)
           (- left-sum)
           right-sum
           (* (- right-count) num-i))))))