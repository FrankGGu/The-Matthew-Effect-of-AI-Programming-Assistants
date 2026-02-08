(define (longest-subarray nums)
  (let loop ([l 0] [r 0] [zero-count 0] [max-len 0])
    (cond
      [(>= r (length nums)) max-len]
      [else
       (let ([current (list-ref nums r)])
         (cond
           [(= current 0)
            (let ([new-zero-count (+ zero-count 1)])
              (cond
                [(> new-zero-count 1)
                 (let loop2 ([l l] [zero-count zero-count])
                   (if (= (list-ref nums l) 0)
                       (loop (+ l 1) (+ r 1) (- zero-count 1) max-len)
                       (loop2 (+ l 1) zero-count)))
                 ]
                [else
                 (loop l (+ r 1) new-zero-count (max max-len (- r l)))]))]
           [else
            (loop l (+ r 1) zero-count (max max-len (- r l)))]))])))