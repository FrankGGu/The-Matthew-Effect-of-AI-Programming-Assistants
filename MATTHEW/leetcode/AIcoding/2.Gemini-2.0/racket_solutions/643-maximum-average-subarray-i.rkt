(define (findMaxAverage nums k)
  (let* ([n (length nums)]
         [sum (apply + (take nums k))]
         [max-sum sum])
    (for ([i (in-range k n)])
      (set! sum (- sum (list-ref nums (- i k))))
      (set! sum (+ sum (list-ref nums i)))
      (set! max-sum (max max-sum sum)))
    (/ max-sum k)))