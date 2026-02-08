(define (sumOfDigitDifferences nums)
  (define (digit-sum n)
    (let loop ((n n) (s 0))
      (if (= n 0)
          s
          (loop (quotient n 10) (+ s (remainder n 10))))))

  (define (digit-diff a b)
    (let ((sa (digit-sum a))
          (sb (digit-sum b)))
      (abs (- sa sb))))

  (define (pair-sum lst)
    (if (null? lst)
        0
        (let loop ((xs lst) (sum 0))
          (if (null? xs)
              sum
              (loop (cdr xs) (+ sum (foldl (lambda (y acc) (+ acc (digit-diff (car xs) y))) 0 (cdr xs))))))))

  (pair-sum nums))