(define (minimum-deletions nums)
  (let* ([n (vector-length nums)])
    (if (= n 1)
        1
        (let* ([min-val (vector-ref nums 0)]
               [max-val (vector-ref nums 0)]
               [min-idx 0]
               [max-idx 0])
          (for ([i (in-range 1 n)])
            (let ([current-val (vector-ref nums i)])
              (when (< current-val min-val)
                (set! min-val current-val)
                (set! min-idx i))
              (when (> current-val max-val)
                (set! max-val current-val)
                (set! max-idx i))))

          (let* ([idx1 min-idx]
                 [idx2 max-idx]
                 [left-idx (min idx1 idx2)]
                 [right-idx (max idx1 idx2)])
            (min
             (+ right-idx 1)
             (- n left-idx)
             (+ (+ left-idx 1)
                (- n right-idx))))))))