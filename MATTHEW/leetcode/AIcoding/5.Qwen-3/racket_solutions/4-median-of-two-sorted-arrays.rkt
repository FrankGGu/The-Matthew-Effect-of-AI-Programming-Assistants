(define (median-nums nums1 nums2)
  (define (find-kth a b k)
    (cond [(null? a) (list-ref b k)]
          [(null? b) (list-ref a k)]
          [else
           (let* ([m (quotient (length a) 2)]
                  [n (quotient (length b) 2)]
                  [am (list-ref a m)]
                  [bn (list-ref b n)])
             (if (< am bn)
                 (find-kth (append (take a (add1 m)) (drop a (add1 m))) b (- k m))
                 (find-kth a (append (take b (add1 n)) (drop b (add1 n))) (- k n))))]))
  (let* ([len1 (length nums1)]
         [len2 (length nums2)]
         [total (+ len1 len2)]
         [mid (quotient total 2)])
    (if (odd? total)
        (find-kth nums1 nums2 mid)
        (/ (+ (find-kth nums1 nums2 (- mid 1)) (find-kth nums1 nums2 mid)) 2.0))))