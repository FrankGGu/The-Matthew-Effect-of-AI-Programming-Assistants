(define (num-subarray-bounded-max nums left right)
  (define (count-subarrays nums left right)
    (let loop ([nums nums] [start 0] [count 0])
      (cond
        [(empty? nums) count]
        [else
         (let loop2 ([i start] [max-val -inf.0] [subarray-count 0])
           (cond
             [(>= i (length nums))
              (loop (cdr nums) (add1 start) (+ count subarray-count))]
             [else
              (let ([current-val (list-ref nums i)])
                (let ([new-max-val (max max-val current-val)])
                  (cond
                    [(and (>= new-max-val left) (<= new-max-val right))
                     (loop2 (add1 i) new-max-val (add1 subarray-count))]
                    [else
                     (loop (cdr nums) (add1 start) (+ count subarray-count))])))])))])))
  (count-subarrays nums left right))