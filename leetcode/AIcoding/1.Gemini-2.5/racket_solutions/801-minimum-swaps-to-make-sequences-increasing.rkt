(define (min-swaps-to-make-sequences-increasing nums1 nums2)
  (let* ([n (vector-length nums1)]
         [infinity (add1 n)]) ; A value larger than any possible number of swaps
    (if (= n 0)
        0
        (let-values (((final-no-swap final-swap)
                      (for/fold ([prev-no-swap 0]
                                 [prev-swap 1])
                                ([i (in-range 1 n)])
                        (let* ([a1 (vector-ref nums1 (- i 1))]
                               [b1 (vector-ref nums2 (- i 1))]
                               [a2 (vector-ref nums1 i)]
                               [b2 (vector-ref nums2 i))]

                               ;; Calculate potential values for curr-no-swap
                               [curr-no-swap-from-prev-no-swap
                                (if (and (< a1 a2) (< b1 b2)) prev-no-swap infinity)]
                               [curr-no-swap-from-prev-swap
                                (if (and (< b1 a2) (< a1 b2)) prev-swap infinity)]

                               ;; Calculate potential values for curr-swap
                               [curr-swap-from-prev-no-swap
                                (if (and (< a1 b2) (< b1 a2)) (+ prev-no-swap 1) infinity)]
                               [curr-swap-from-prev-swap
                                (if (and (< b1 b2) (< a1 a2)) (+ prev-swap 1) infinity)])

                          (values (min curr-no-swap-from-prev-no-swap curr-no-swap-from-prev-swap)
                                  (min curr-swap-from-prev-no-swap curr-swap-from-prev-swap))))))
          (min final-no-swap final-swap)))))