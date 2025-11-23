(define/contract (min-operations nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([sum1 (apply + nums1)]
         [sum2 (apply + nums2)]
         [diff (abs (- sum1 sum2))])
    (if (zero? diff)
        0
        (let* ([larger (if (> sum1 sum2) nums1 nums2)]
               [smaller (if (> sum1 sum2) nums2 nums1)]
               [larger-decreases (sort (map (lambda (x) (- x 1)) larger) >)]
               [smaller-increases (sort (map (lambda (x) (- 6 x)) smaller) >)]
               [changes (append larger-decreases smaller-increases)]
               [sorted-changes (sort changes >)]
               [res 0]
               [remaining diff])
          (for ([change (in-list sorted-changes)]
                #:break (<= remaining 0))
            (set! res (add1 res))
            (set! remaining (- remaining change)))
          (if (<= remaining 0) res -1)))))