(define (max-profit prices)
  (let ((n (vector-length prices)))
    (if (<= n 1)
        0
        (let loop ((i 1)
                   (min-price (vector-ref prices 0))
                   (max-profit 0))
          (if (= i n)
              max-profit
              (let* ((current-price (vector-ref prices i))
                     (new-min-price (min min-price current-price))
                     (current-profit (- current-price min-price))
                     (new-max-profit (max max-profit current-profit)))
                (loop (+ i 1) new-min-price new-max-profit)))))))