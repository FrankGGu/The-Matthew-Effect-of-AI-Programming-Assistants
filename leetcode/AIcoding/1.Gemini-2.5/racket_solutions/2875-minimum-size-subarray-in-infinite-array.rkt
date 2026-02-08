#lang racket

(define (min-size-subarray-in-infinite-array nums target)
  (let* ([n (length nums)]
         [sum-nums (apply + nums)]
         [nums-vec (list->vector nums)])

    ; Constraints: 1 <= nums[i] <= 10^9, 1 <= target <= 10^9
    ; This implies sum-nums will always be > 0 and target will always be > 0.
    ; Thus, no need to handle target=0 or sum-nums=0 cases explicitly for problem constraints.

    (let* ([num-full-repetitions (quotient target sum-nums)]
           [remaining-target (- target (* num-full-repetitions sum-nums))]
           [base-len (* num-full-repetitions n)]
           ; Create an extended vector by appending nums to itself for efficient O(1) access.
           ; This allows handling subarrays that wrap around the original 'nums' array.
           [extended-vec (make-vector (* 2 n))]
           ; Initialize min-len-for-rem:
           ; If remaining-target is 0, we need a subarray of length 0.
           ; Otherwise, initialize with a value larger than any possible length for remaining-target.
           [min-len-for-rem (if (= remaining-target 0) 0 (add1 (* 2 n)))])

      ; Populate extended-vec by repeating nums twice.
      (for ([i (in-range n)])
        (vector-set! extended-vec i (vector-ref nums-vec i))
        (vector-set! extended-vec (+ i n) (vector-ref nums-vec i)))

      ; Only run the sliding window if remaining-target is not 0.
      ; If remaining-target is 0, min-len-for-rem is already correctly set to 0.
      (when (not (= remaining-target 0))
        (let* ([current-sum 0]
               [left 0])
          (for ([right (in-range (* 2 n))])
            (set! current-sum (+ current-sum (vector-ref extended-vec right)))
            (while (>= current-sum remaining-target)
              (when (= current-sum remaining-target)
                (set! min-len-for-rem (min min-len-for-rem (add1 (- right left)))))
              (set! current-sum (- current-sum (vector-ref extended-vec left)))
              (set! left (add1 left))))))

      ; If min-len-for-rem is still its initial "infinity" value (for non-zero remaining-target),
      ; it means no subarray for remaining-target was found.
      (if (= min-len-for-rem (add1 (* 2 n)))
          -1 ; Cannot find a subarray for the remaining target
          (+ base-len min-len-for-rem)))))