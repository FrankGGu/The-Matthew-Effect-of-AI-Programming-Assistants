(define (min-increment-for-unique A)
  (if (empty? A)
      0
      (let* ([sorted-A (sort A <)]
             [first-val (car sorted-A)])
        (let loop ([lst (cdr sorted-A)]
                   [prev-val first-val]
                   [total-moves 0])
          (if (empty? lst)
              total-moves
              (let* ([current-val (car lst)]
                     [new-prev-val (if (<= current-val prev-val)
                                       (+ prev-val 1)
                                       current-val)]
                     [moves-for-current (if (<= current-val prev-val)
                                            (- (+ prev-val 1) current-val)
                                            0)])
                (loop (cdr lst)
                      new-prev-val
                      (+ total-moves moves-for-current))))))))