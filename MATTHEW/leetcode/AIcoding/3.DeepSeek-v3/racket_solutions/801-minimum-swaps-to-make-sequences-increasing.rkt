(define (min-swaps nums1 nums2)
  (let loop ([i 1] [n (vector-length nums1)] [swap 1] [no-swap 0])
    (if (= i n)
        (min swap no-swap)
        (let* ([a1 (vector-ref nums1 (sub1 i))]
               [a2 (vector-ref nums1 i)]
               [b1 (vector-ref nums2 (sub1 i))]
               [b2 (vector-ref nums2 i)]
               [new-swap +inf.0]
               [new-no-swap +inf.0])
          (when (and (< a1 a2) (< b1 b2))
            (set! new-no-swap (min new-no-swap no-swap))
            (set! new-swap (min new-swap (add1 swap))))
          (when (and (< b1 a2) (< a1 b2))
            (set! new-no-swap (min new-no-swap swap))
            (set! new-swap (min new-swap (add1 no-swap))))
          (loop (add1 i) n new-swap new-no-swap)))))