(define (wiggle-sort nums)
  (define (swap lst i j)
    (let ((temp (list-ref lst i)))
      (set! lst (list-set! lst i (list-ref lst j)))
      (set! lst (list-set! lst j temp))))

  (define n (length nums))
  (define half (+ (quotient n 2) (modulo n 2)))
  (define sorted (sort nums <))

  (define (index i)
    (if (even? i)
        (quotient i 2)
        (+ half (quotient i 2))))

  (for-each (lambda (i)
              (set! nums (list-set! nums i (list-ref sorted (index i)))))
            (range n))
  nums)