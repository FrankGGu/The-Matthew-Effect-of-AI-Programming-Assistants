(define (peak-index-in-mountain-array arr)
  (let loop ([l 0] [r (- (length arr) 1)])
    (if (> l r)
        l
        (let* ([mid (floor (/ (+ l r) 2))]
               [left-val (list-ref arr (- mid 1))]
               [mid-val (list-ref arr mid)]
               [right-val (list-ref arr (+ mid 1))])
          (if (> mid-val left-val)
              (if (> mid-val right-val)
                  mid
                  (loop (+ mid 1) r))
              (loop l (- mid 1)))))))