(define (max-frequency nums k)
  (let* ([n (length nums)]
         [sorted-nums-list (sort nums <)]
         [sorted-nums (list->vector sorted-nums-list)])
    (for/fold ([left 0]
               [current-sum 0]
               [max-freq 0])
              ([right (in-range n)])
      (let* ([num-right (vector-ref sorted-nums right)]
             [new-current-sum (+ current-sum num-right)])

        (let loop-shrink ([current-left left]
                          [current-window-sum new-current-sum])
          (let* ([window-size (+ (- right current-left) 1)]
                 [cost (- (* num-right window-size) current-window-sum)])
            (if (> cost k)
                (let* ([num-left (vector-ref sorted-nums current-left)]
                       [sum-after-remove (- current-window-sum num-left)])
                  (loop-shrink (+ current-left 1) sum-after-remove))
                (values current-left
                        current-window-sum
                        (max max-freq window-size)))))))))