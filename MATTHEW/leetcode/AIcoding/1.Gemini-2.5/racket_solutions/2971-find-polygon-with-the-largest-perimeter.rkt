(define (largest-perimeter nums)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))

  (if (< n 3)
      -1
      (for/fold ((current-sum 0)
                 (max-perimeter -1))
                ((num sorted-nums))
        (define next-sum (+ current-sum num))
        (if (> current-sum num)
            (values next-sum next-sum)
            (values next-sum max-perimeter)))))