(define (min-operations nums1 nums2 k)
  (let* ([n (length nums1)]
         [diffs (map - nums2 nums1)])

    (cond
      [(zero? k)
       (if (andmap zero? diffs)
           0
           -1)]

      [else
       (let loop ([ds diffs]
                  [total-inc-ops 0]
                  [total-dec-ops 0])
         (cond
           [(empty? ds)
            (if (= total-inc-ops total-dec-ops)
                total-inc-ops
                -1)]

           [else
            (let ([d (car ds)])
              (cond
                [(not (zero? (remainder d k)))
                 -1]

                [(positive? d)
                 (loop (cdr ds) (+ total-inc-ops (/ d k)) total-dec-ops)]

                [(negative? d)
                 (loop (cdr ds) total-inc-ops (+ total-dec-ops (/ (- d) k)))]

                [else
                 (loop (cdr ds) total-inc-ops total-dec-ops)])))])))