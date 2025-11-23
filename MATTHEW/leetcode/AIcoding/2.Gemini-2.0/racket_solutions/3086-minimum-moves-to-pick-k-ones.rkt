(define (min-moves nums k)
  (let* ([indices (for/list ([i (in-range (length nums))] #:when (= (list-ref nums i) 1)) i)]
         [n (length indices)])
    (if (or (= k 0) (= n 0) (> k n))
        0
        (let loop ([i 0] [min-moves +inf.0])
          (if (> i (- n k))
              min-moves
              (let* ([mid (quotient k 2)]
                     [median-index (+ i mid)]
                     [median (list-ref indices median-index)]
                     [current-moves (let inner-loop ([j i] [sum 0])
                                       (if (= j (+ i k))
                                           sum
                                           (let ([index (list-ref indices j)])
                                             (inner-loop (+ j 1) (+ sum (abs (- index (+ median (- mid) (+ j (- i)))))))))])
                     )
                (loop (+ i 1) (min min-moves current-moves))))))))