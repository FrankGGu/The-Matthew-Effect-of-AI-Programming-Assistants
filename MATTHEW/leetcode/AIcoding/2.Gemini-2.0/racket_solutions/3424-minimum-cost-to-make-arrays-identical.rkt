(define (minCost nums cost)
  (define n (length nums))
  (define (median nums)
    (define sorted-nums (sort nums <))
    (if (odd? n)
        (list-ref sorted-nums (quotient n 2))
        (/ (+ (list-ref sorted-nums (sub1 (quotient n 2)))
              (list-ref sorted-nums (quotient n 2)))
           2)))

  (define m (median nums))

  (define (calculate-cost target)
    (foldl + 0
           (for/list ([i (in-range n)])
             (* (abs (- (list-ref nums i) target)) (list-ref cost i)))))

  (if (integer? m)
      (calculate-cost m)
      (min (calculate-cost (floor m)) (calculate-cost (ceiling m)))))