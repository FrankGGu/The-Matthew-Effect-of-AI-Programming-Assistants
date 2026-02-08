(define (maximum-removals nums1 nums2)
  (define n (vector-length nums1))
  (define m (vector-length nums2))

  (define (check mid)
    (define v1 (vector))
    (define v2 (vector))
    (define i 0)
    (define j 0)
    (for ([k (in-range mid)])
      (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
          (vector-set! v1 i (vector-ref nums1 k))
          (vector-set! v2 j (vector-ref nums2 (- m mid k 1))))
      (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
          (begin (set! i (+ i 1)))
          (begin (set! j (+ j 1)))))

    (define i 0)
    (define j 0)
    (define count 0)
    (define v1-len i)
    (define v2-len j)

    (for ([k (in-range mid)])
        (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
            (begin
              (if (<= i v1-len)
                 (begin
                   (if (<= j v2-len)
                       (begin
                         (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
                             (set! count (+ count 1))))))))
            (begin
              (if (<= i v1-len)
                  (begin
                    (if (<= j v2-len)
                        (begin
                         (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
                             (set! count (+ count 1)))))))))
        (if (< (vector-ref nums1 k) (vector-ref nums2 (- m mid k 1)))
            (set! i (+ i 1))
            (set! j (+ j 1))))

    (if (= count mid)
        #t
        #f))

  (define (binary-search low high)
    (if (> low high)
        (- low 1)
        (let ([mid (floor (/ (+ low high) 2))])
          (if (check mid)
              (binary-search (+ mid 1) high)
              (binary-search low (- mid 1))))))

  (binary-search 0 (min n m)))