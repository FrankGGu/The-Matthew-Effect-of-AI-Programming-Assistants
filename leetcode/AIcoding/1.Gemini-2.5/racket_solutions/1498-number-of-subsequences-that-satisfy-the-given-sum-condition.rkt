(define (num-subseqs nums target)
  (define MOD 1000000007)
  (define n (length nums))

  (when (zero? n)
    (if (<= 0 target) 0 0)) ; If nums is empty, no subsequences, so 0.

  ;; Sort the list and convert to a vector for O(1) access
  (define sorted-vec (list->vector (sort nums <)))

  ;; Precompute powers of 2 modulo MOD
  ;; pow2[i] will store 2^i % MOD
  (define pow2 (make-vector (+ n 1)))
  (vector-set! pow2 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! pow2 i (modulo (* (vector-ref pow2 (- i 1)) 2) MOD)))

  (define left 0)
  (define right (- n 1))
  (define count 0)

  (while (<= left right)
    (if (<= (+ (vector-ref sorted-vec left) (vector-ref sorted-vec right)) target)
        ;; If nums[left] + nums[right] <= target,
        ;; then nums[left] can be the minimum element of a valid subsequence.
        ;; All subsequences formed by including nums[left] and any subset of elements
        ;; from nums[left+1] to nums[right] will satisfy the condition.
        ;; The count of such subsequences is 2^(right - left).
        (begin
          (set! count (modulo (+ count (vector-ref pow2 (- right left))) MOD))
          (set! left (+ left 1)))
        ;; If nums[left] + nums[right] > target,
        ;; then nums[right] is too large to be the maximum element for nums[left].
        ;; We must try a smaller maximum element.
        (set! right (- right 1))))

  count)