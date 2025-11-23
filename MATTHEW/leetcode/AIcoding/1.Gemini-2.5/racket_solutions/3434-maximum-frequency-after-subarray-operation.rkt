(define (max-frequency nums k)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [arr (list->vector sorted-nums)])
    (let loop ([left 0]
               [right 0]
               [current-sum 0]
               [max-freq 0])
      (if (= right n)
          max-freq
          (let* ([current-num-at-right (vector-ref arr right)]
                 [new-sum (+ current-sum current-num-at-right)])
            (let loop-shrink ([l left]
                              [s new-sum])
              (let* ([window-size (+ (- right l) 1)]
                     [cost (- (* current-num-at-right window-size) s)])
                (if (> cost k)
                    (loop-shrink (+ l 1) (- s (vector-ref arr l)))
                    (loop l
                          (+ right 1)
                          s
                          (max max-freq window-size))))))))))