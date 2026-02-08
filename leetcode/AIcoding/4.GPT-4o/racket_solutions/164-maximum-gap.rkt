(define (maximumGap nums)
  (if (or (null? nums) (< (length nums) 2))
      0
      (let* ([min-val (apply min nums)]
             [max-val (apply max nums)]
             [n (length nums)]
             [bucket-size (max 1 (ceiling (/ (- max-val min-val) (sub1 n))))]
             [bucket-count (ceiling (/ (- max-val min-val) bucket-size))]
             [buckets (make-vector bucket-count '())])
        (for ([num nums])
          (define bucket-index (quotient (- num min-val) bucket-size))
          (let ([bucket (vector-ref buckets bucket-index)])
            (if (null? bucket)
                (vector-set! buckets bucket-index (list num))
                (vector-set! buckets bucket-index (cons num bucket)))))
        (define (gap buckets)
          (define (helper prev max-gap)
            (if (null? buckets)
                max-gap
                (let ([current (car buckets)])
                  (if (null? current)
                      (helper (cdr buckets) max-gap)
                      (let ([current-max (apply max current)]
                            [current-min (apply min current)])
                        (helper (cdr buckets)
                                (max max-gap (- current-min prev)))))))
          (helper (apply max (map (lambda (bucket) (if (null? bucket) -inf. (apply max bucket))) buckets))
                  0))
        (gap buckets)))))