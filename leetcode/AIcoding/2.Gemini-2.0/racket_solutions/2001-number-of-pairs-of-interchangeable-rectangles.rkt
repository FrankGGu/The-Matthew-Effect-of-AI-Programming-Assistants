(define (count-interchangeable-rectangles rectangles)
  (let ([ratios (make-hash)])
    (for ([rect rectangles])
      (let ([width (first rect)]
            [height (second rect)])
        (let ([ratio (/ width height)])
          (hash-update ratios ratio (λ (v) (+ v 1)) 1))))
    (let loop ([counts (hash-values ratios)]
               [total 0])
      (cond
        [(empty? counts) total]
        [else (let ([count (first counts)])
                (loop (rest counts) (+ total (/ (* count (- count 1)) 2))))]))))