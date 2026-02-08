(define (maximum-subarray-sum nums x)
  (let* ((n (length nums))
         (max-sum (let loop ((i 0) (curr-max 0) (overall-max -inf.0))
                     (if (= i n)
                         overall-max
                         (let* ((num (list-ref nums i)))
                           (if (= num x)
                               (loop (+ i 1) 0 overall-max)
                               (let* ((new-curr-max (max 0 (+ curr-max num)))
                                      (new-overall-max (max overall-max new-curr-max)))
                                 (loop (+ i 1) new-curr-max new-overall-max))))))))
    (if (equal? max-sum -inf.0)
        0
        max-sum)))