(define (max-sum nums)
  (define (max-digit n)
    (if (< n 10)
        n
        (max (remainder n 10) (max-digit (quotient n 10)))))

  (define max-sum -1)
  (define n (length nums))

  (for ([i (in-range n)])
    (for ([j (in-range (add1 i) n)])
      (when (= (max-digit (list-ref nums i)) (max-digit (list-ref nums j)))
        (define current-sum (+ (list-ref nums i) (list-ref nums j)))
        (when (> current-sum max-sum)
          (set! max-sum current-sum)))))

  (if (= max-sum -1) -1 max-sum))