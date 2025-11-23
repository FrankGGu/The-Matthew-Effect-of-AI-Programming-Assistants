(define (minimum-difference nums k)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (if (= k 1)
      0
      (let loop ((i 0)
                 (min-diff +inf.0))
        (if (> (+ i k -1) (- n 1))
            min-diff
            (let* ((low (list-ref sorted-nums i))
                   (high (list-ref sorted-nums (+ i k -1)))
                   (current-diff (- high low)))
              (loop (+ i 1) (min min-diff current-diff)))))))