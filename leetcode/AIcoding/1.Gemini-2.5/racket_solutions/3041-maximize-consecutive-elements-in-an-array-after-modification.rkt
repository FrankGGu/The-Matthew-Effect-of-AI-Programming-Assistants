(define (maximize-consecutive-elements nums)
  (let ([n (length nums)])
    (if (= n 0)
        0
        (let* ([sorted-nums (sort nums <)]
               [max-len 1]
               [left 0]
               [gaps 0])
          (for ([right (in-range n)])
            (when (> right 0)
              (let ([current-val (list-ref sorted-nums right)]
                    [prev-val (list-ref sorted-nums (- right 1))])
                (when (> current-val (+ prev-val 1))
                  (set! gaps (+ gaps 1)))))

            (let loop ()
              (when (and (> gaps 1) (< left right))
                (let ([left-val (list-ref sorted-nums left)]
                      [next-left-val (list-ref sorted-nums (+ left 1))])
                  (when (> next-left-val (+ left-val 1))
                    (set! gaps (- gaps 1))))
                (set! left (+ left 1))
                (loop)))

            (let* ([current-span (+ (- (list-ref sorted-nums right) (list-ref sorted-nums left)) 1)]
                   [current-effective-len (if (= gaps 0)
                                              (+ current-span 1)
                                              current-span)])
              (set! max-len (max max-len current-effective-len)))
            )
          max-len))))