(define (diagonal-sum mat)
  (let ((n (length mat)))
    (let loop ((i 0) (sum 0))
      (if (= i n)
          sum
          (loop (+ i 1) (+ sum (list-ref (list-ref mat i) i) (list-ref (list-ref mat (- n 1 i)) i)))))))