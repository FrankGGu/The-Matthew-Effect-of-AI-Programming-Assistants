(define (dominant-index nums)
  (let* ([n (vector-length nums)])
    (cond
      [(= n 0) -1]
      [(= n 1) 0]
      [else
       (let ([max1 -1]
             [max2 -1]
             [max-idx -1])
         (for ([i (in-range n)])
           (let ([current-val (vector-ref nums i)])
             (cond
               [(> current-val max1)
                (set! max2 max1)
                (set! max1 current-val)
                (set! max-idx i)]
               [(> current-val max2)
                (set! max2 current-val)])))
         (if (>= max1 (* 2 max2))
             max-idx
             -1))])))