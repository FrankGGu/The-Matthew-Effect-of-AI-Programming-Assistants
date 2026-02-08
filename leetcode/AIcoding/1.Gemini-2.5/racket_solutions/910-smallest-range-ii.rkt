(define (smallest-range-ii a k)
  (let* ([n (length a)]
         [sorted-a (sort a <)])
    (if (<= n 1)
        0
        (let ([initial-ans (- (list-ref sorted-a (- n 1)) (list-ref sorted-a 0))])
          (let loop ([i 0] [min-diff initial-ans])
            (if (>= i (- n 1))
                min-diff
                (let* ([min-val (min (+ (list-ref sorted-a 0) k)
                                     (- (list-ref sorted-a (+ i 1)) k))]
                       [max-val (max (+ (list-ref sorted-a i) k)
                                     (- (list-ref sorted-a (- n 1)) k))]
                       [current-diff (- max-val min-val)])
                  (loop (+ i 1) (min min-diff current-diff)))))))))