(define (maximize-total-amount-after-two-days nums initialAmount)
  (let* ([n (length nums)]
         [sorted-nums (sort nums >)] ; Sort in descending order
         [total-sum-of-nums (apply + sorted-nums)]
         [max-gain 0] ; Initialize max-gain with 0 (represents the case where no operations are performed)
         [current-day1-sum 0])

    (when (> n 0)
      (for ([k (in-range n)]) ; k represents the number of elements chosen for Day 1
        (set! current-day1-sum (+ current-day1-sum (list-ref sorted-nums k)))
        (let* ([current-day2-sum (- total-sum-of-nums current-day1-sum)]
               [current-gain (+ current-day1-sum (quotient current-day2-sum 2))])
          (set! max-gain (max max-gain current-gain)))))

    (+ initialAmount max-gain)))