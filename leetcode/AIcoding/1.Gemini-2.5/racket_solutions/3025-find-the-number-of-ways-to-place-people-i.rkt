(define (number-of-ways-to-place-people points)
  (let* ([n (length points)]
         [count 0])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (not (= i j))
          (let* ([p1 (list-ref points i)]
                 [p2 (list-ref points j)]
                 [x1 (list-ref p1 0)]
                 [y1 (list-ref p1 1)]
                 [x2 (list-ref p2 0)]
                 [y2 (list-ref p2 1)])

            (when (and (<= x1 x2) (<= y1 y2))
              (let ([has-intermediate-point
                     (for/or ([k (in-range n)])
                       (and (not (= k i))
                            (not (= k j))
                            (let* ([p3 (list-ref points k)]
                                   [x3 (list-ref p3 0)]
                                   [y3 (list-ref p3 1)])
                              (and (<= x1 x3 x2) (<= y1 y3 y2)))))]
                (when (not has-intermediate-point)
                  (set! count (+ count 1))))))))
    count))