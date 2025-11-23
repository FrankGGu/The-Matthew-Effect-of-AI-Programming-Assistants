(define (minimum-time nums1 nums2 x)
  (let* ([n (length nums1)]
         [indices (range n)]
         [sorted-indices (sort indices (lambda (i j) (< (list-ref nums2 i) (list-ref nums2 j))))]
         [sum-nums1 (apply + nums1)]
         [sum-nums2 (apply + nums2)]
         (define (check time)
           (let* ([current-sum (+ sum-nums1 (* time sum-nums2))]
                  [dp (make-vector (+ n 1) 0)])
             (vector-set! dp 0 0)
             (for ([i (in-range n)])
               (let ([index (list-ref sorted-indices i)])
                 (for ([j (in-range (- (+ n 1) 1) -1 -1)])
                   (when (>= j 1)
                     (vector-set! dp j (max (vector-ref dp j) (+ (vector-ref dp (- j 1)) (+ (list-ref nums1 index) (* time (list-ref nums2 index))))))))))
             (<= (+ sum-nums1 (* time sum-nums2) (vector-ref dp n)) x))))
    (let loop ([low 0] [high n])
      (cond
        [(>= low high) (if (check low) low -1)]
        [else
         (let ([mid (quotient (+ low high) 2)])
           (if (check mid)
               (loop low mid)
               (loop (+ mid 1) high)))]))))