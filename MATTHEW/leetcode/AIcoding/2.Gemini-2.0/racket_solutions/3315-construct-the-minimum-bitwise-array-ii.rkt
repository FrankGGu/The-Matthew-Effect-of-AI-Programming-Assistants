(define (minimum-xor-sum nums1 nums2)
  (define n (length nums1))
  (define memo (make-hash))

  (define (solve mask idx)
    (if (= idx n)
        0
        (hash-ref! memo (cons mask idx)
                   (lambda ()
                     (let loop ((i 0) (min-sum +inf.0))
                       (cond
                         ((= i n) min-sum)
                         ((bitwise-bit-set? mask i) (loop (+ i 1) min-sum))
                         (else (loop (+ i 1) (min min-sum (+ (bitwise-xor (list-ref nums1 idx) (list-ref nums2 i)) (solve (bitwise-ior mask (bitwise-arithmetic-shift 1 i)) (+ idx 1))))))))))))

  (solve 0 0))