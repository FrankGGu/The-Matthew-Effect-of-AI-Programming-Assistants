#lang racket

(define (good-pairs-ii nums1 nums2 k)
  (if (= k 0)
      ; If k is 0, nums2[j] * k will always be 0.
      ; Since nums1[i] >= 1, nums1[i] cannot be divisible by 0.
      ; Thus, there are no good pairs.
      0
      (let* ((freq-nums2 (make-hash)))
        ; Populate a frequency map for nums2 to count occurrences of each number.
        (for ([val (in-vector nums2)])
          (hash-set! freq-nums2 val (+ (hash-ref freq-nums2 val 0) 1)))

        ; Iterate through each number in nums1
        (for/sum ([x (in-vector nums1)])
          (if (not (= (remainder x k) 0))
              ; If x is not divisible by k, then x cannot be divisible by (y * k) for any y.
              0
              (let* ((val-prime (/ x k)))
                ; We need to find y in nums2 such that val-prime is divisible by y.
                ; This means y must be a divisor of val-prime.
                ; Iterate through possible divisors 'd' of val-prime up to its square root.
                (for/sum ([d (in-range 1 (add1 (floor (sqrt val-prime))))])
                  (if (= (remainder val-prime d) 0)
                      (let* ((d-complement (/ val-prime d))
                             (count-d (hash-ref freq-nums2 d 0))) ; Count occurrences of divisor d in nums2
                        (if (= d d-complement)
                            ; If d is the square root, it's counted once.
                            count-d
                            ; If d and d-complement are distinct divisors, count both.
                            (+ count-d (hash-ref freq-nums2 d-complement 0))))
                      0))))))))