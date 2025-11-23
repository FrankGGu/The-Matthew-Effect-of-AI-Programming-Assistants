(define (minimumDifference K nums)
  (define (calculate-min-diff lst)
    (if (null? lst) +inf.0
        (let ((high (car lst))
              (low (car lst)))
          (for-each (lambda (x)
                      (set! high (max high x))
                      (set! low (min low x)))
                    lst)
          (- high low))))

  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define min-diff +inf.0)

  (for ((i 0 (+ i 1)))
    (when (>= (+ i K) n)
      (set! min-diff (min min-diff (calculate-min-diff (sublist sorted-nums i (+ i K)))))))

  min-diff)