(define (maximum-gap nums)
  (let* ([n (length nums)]
         [min-val (apply min nums)]
         [max-val (apply max nums)])
    (if (< n 2)
        0
        (let* ([bucket-size (max 1 (floor (/ (- max-val min-val) (- n 1))))]
               [bucket-count (+ 1 (quotient (- max-val min-val) bucket-size))]
               [buckets (make-vector bucket-count '())])
          (for ([num nums])
            (let* ([index (quotient (- num min-val) bucket-size)])
              (vector-set! buckets index (cons num (vector-ref buckets index)))))
          (let loop ([prev-max min-val]
                     [max-gap 0]
                     [i 0])
            (cond
              [(>= i bucket-count)
               max-gap]
              [(empty? (vector-ref buckets i))
               (loop prev-max max-gap (+ i 1))]
              [else
               (let* ([bucket (vector-ref buckets i)]
                      [bucket-min (apply min bucket)]
                      [bucket-max (apply max bucket)]
                      [new-max-gap (max max-gap (- bucket-min prev-max))])
                 (loop bucket-max new-max-gap (+ i 1)))])))))))