(define/contract (max-non-decreasing-length nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([i 1]
             [len1 1]
             [len2 1]
             [max-len 1])
    (if (>= i (length nums1))
        max-len
        (let* ([prev1 (list-ref nums1 (- i 1))]
               [prev2 (list-ref nums2 (- i 1))]
               [curr1 (list-ref nums1 i)]
               [curr2 (list-ref nums2 i)]
               [new-len1 1]
               [new-len2 1])
          (when (>= curr1 prev1)
            (set! new-len1 (max new-len1 (+ len1 1))))
          (when (>= curr1 prev2)
            (set! new-len1 (max new-len1 (+ len2 1))))
          (when (>= curr2 prev1)
            (set! new-len2 (max new-len2 (+ len1 1))))
          (when (>= curr2 prev2)
            (set! new-len2 (max new-len2 (+ len2 1))))
          (loop (+ i 1)
                new-len1
                new-len2
                (max max-len new-len1 new-len2))))))