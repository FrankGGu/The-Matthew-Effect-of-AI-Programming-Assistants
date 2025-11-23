(define (minOperations nums x)
  (let* ([n (length nums)]
         [target (- (apply + nums) x)]
         [max-len -1])
    (let loop ([i 0] [j 0] [curr-sum 0])
      (cond
        [(>= j n)
         (cond
           [(< max-len 0) -1]
           [else (- n max-len)])]
        [else
         (let ([new-sum (+ curr-sum (list-ref nums j))])
           (cond
             [(< new-sum target)
              (loop i (+ j 1) new-sum)]
             [(= new-sum target)
              (set! max-len (max max-len (+ j 1 i)))
              (loop i (+ j 1) new-sum)]
             [else
              (let loop2 ([curr-i i] [curr-sum2 new-sum])
                (cond
                  [(> curr-i j)
                   (loop i (+ j 1) curr-sum)]
                  [else
                   (let ([new-sum2 (- curr-sum2 (list-ref nums curr-i))])
                     (cond
                       [(< new-sum2 target)
                        (loop (+ curr-i 1) (+ j 1) new-sum2)]
                       [(= new-sum2 target)
                        (set! max-len (max max-len (- (+ j 1) (+ curr-i 1))))
                        (loop (+ curr-i 1) (+ j 1) new-sum2)]
                       [else
                        (loop2 (+ curr-i 1) new-sum2)])))]))]
              )))]))]))