(define (min-swaps nums k)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)])

    (define good-count
      (for/fold ([count 0])
                ([x nums])
                (if (<= x k) (+ count 1) count)))

    (if (<= good-count 1)
        0
        (let* ([initial-window-good-count
                (for/fold ([count 0])
                          ([i (in-range good-count)])
                          (if (<= (vector-ref nums-vec i) k) (+ count 1) count))])

          (let-values ([(final-current-good final-max-good)
                        (for/fold ([current-good initial-window-good-count]
                                   [max-good initial-window-good-count])
                                  ([i (in-range good-count n)])

                                  (let* ([leaving-val (vector-ref nums-vec (- i good-count))]
                                         [entering-val (vector-ref nums-vec i)]
                                         [new-current-good
                                          (+ current-good
                                             (if (<= entering-val k) 1 0)
                                             (if (<= leaving-val k) -1 0))])
                                    (values new-current-good (max max-good new-current-good))))])
            (- good-count final-max-good))))))