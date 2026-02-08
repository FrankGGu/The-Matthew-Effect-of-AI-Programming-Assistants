(define (number-of-arrays differences lower upper)
  (let loop ([i 0]
             [current 0]
             [min-val 0]
             [max-val 0])
    (if (= i (length differences))
        (max 0 (+ 1 (- upper lower) (- max-val min-val)))
        (let ([next (+ current (list-ref differences i))])
          (loop (+ i 1)
                next
                (min min-val next)
                (max max-val next))))))