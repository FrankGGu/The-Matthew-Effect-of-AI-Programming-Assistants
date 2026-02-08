(define (maximize-area-of-square-hole n m hBars vBars)
  (define (get-max-consecutive-length bars)
    (if (empty? bars)
        0
        (let loop ((sorted-bars (sort bars <))
                   (current-count 1)
                   (max-count 1))
          (if (empty? (rest sorted-bars))
              max-count
              (if (= (add1 (first sorted-bars)) (second sorted-bars))
                  (loop (rest sorted-bars)
                        (add1 current-count)
                        (max (add1 current-count) max-count))
                  (loop (rest sorted-bars)
                        1
                        max-count))))))

  (define max-consecutive-h (get-max-consecutive-length hBars))
  (define max-consecutive-v (get-max-consecutive-length vBars))

  (define side-h (max 0 (- max-consecutive-h 1)))
  (define side-v (max 0 (- max-consecutive-v 1)))

  (define k (min side-h side-v))
  (* k k))