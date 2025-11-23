(define (沙地治理 nums k)
  (let* ([n (length nums)]
         [sorted-list (sort nums <)]
         [sorted-vec (list->vector sorted-list)])
    (if (= n 0)
        0
        (let loop ([left 0]
                   [max-len 0]
                   [right 0])
          (if (= right n)
              max-len
              (let* ([current-right-val (vector-ref sorted-vec right)]
                     [new-left (let inner-loop ([current-left left])
                                 (if (> (- current-right-val (vector-ref sorted-vec current-left)) k)
                                     (inner-loop (+ current-left 1))
                                     current-left))]
                     [current-window-len (+ 1 (- right new-left))])
                (loop new-left
                      (max max-len current-window-len)
                      (+ right 1))))))))