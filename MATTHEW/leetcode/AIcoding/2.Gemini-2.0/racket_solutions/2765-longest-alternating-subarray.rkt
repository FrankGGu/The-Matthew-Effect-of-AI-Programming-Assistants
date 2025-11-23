(define (longest-alternating-subarray nums)
  (let* ([n (length nums)]
         [max-len 0])
    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (let loop ([k i] [prev-diff #f] [curr-len 0])
          (cond
            [(= k j)
             (set! max-len (max max-len curr-len))]
            [else
             (let ([curr-diff (- (list-ref nums (+ k 1)) (list-ref nums k))])
               (cond
                 [(and prev-diff (= curr-diff prev-diff))
                  (void)]
                 [(and prev-diff (= curr-diff (* -1 prev-diff)))
                  (loop (+ k 1) curr-diff (+ curr-len 1))]
                 [(not prev-diff)
                  (loop (+ k 1) curr-diff (+ curr-len 1))]
                 [else
                  (void)])))))))
    max-len))