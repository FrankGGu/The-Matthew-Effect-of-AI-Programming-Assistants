(define (max-points-inside-square points side)
  (let* ([n (length points)]
         [max-points 0])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (let ([p1 (list-ref points i)]
              [p2 (list-ref points j)])
          (let ([x1 (car p1)]
                [y1 (cadr p1)]
                [x2 (car p2)]
                [y2 (cadr p2)])
            (let ([count 0]
                  [xmin (min x1 x2)]
                  [ymin (min y1 y2)])
              (set! count 0)
              (for ([k (in-range n)])
                (let ([p (list-ref points k)])
                  (let ([x (car p)]
                        [y (cadr p)])
                    (when (and (<= xmin x (+ xmin side))
                                (<= ymin y (+ ymin side)))
                      (set! count (+ count 1))))))
              (set! max-points (max max-points count))
              (set! count 0)
              (for ([k (in-range n)])
                (let ([p (list-ref points k)])
                  (let ([x (car p)]
                        [y (cadr p)])
                    (when (and (<= xmin x (+ xmin side))
                                (<= (- ymin side) y ymin))
                      (set! count (+ count 1))))))
              (set! max-points (max max-points count))
              (set! count 0)
              (for ([k (in-range n)])
                (let ([p (list-ref points k)])
                  (let ([x (car p)]
                        [y (cadr p)])
                    (when (and (<= (- xmin side) x xmin)
                                (<= ymin y (+ ymin side)))
                      (set! count (+ count 1))))))
              (set! max-points (max max-points count))
              (set! count 0)
              (for ([k (in-range n)])
                (let ([p (list-ref points k)])
                  (let ([x (car p)]
                        [y (cadr p)])
                    (when (and (<= (- xmin side) x xmin)
                                (<= (- ymin side) y ymin))
                      (set! count (+ count 1))))))
              (set! max-points (max max-points count))))))))
    max-points))