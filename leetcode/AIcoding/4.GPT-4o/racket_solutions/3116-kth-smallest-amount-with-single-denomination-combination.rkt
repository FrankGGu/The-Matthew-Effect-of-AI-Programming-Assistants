(define (getKthSmallestAmount coins k)
  (define (count-ways amount)
    (if (= amount 0) 1
        (if (< amount 0) 0
            (foldl (lambda (coin acc) (+ acc (count-ways (- amount coin)))) 0 coins))))
  (define (find-smallest-amount k)
    (if (= k 0) 0
        (let loop ((amount 1))
          (let ((ways (count-ways amount)))
            (if (>= ways k)
                amount
                (loop (+ amount 1)))))))
  (find-smallest-amount k))