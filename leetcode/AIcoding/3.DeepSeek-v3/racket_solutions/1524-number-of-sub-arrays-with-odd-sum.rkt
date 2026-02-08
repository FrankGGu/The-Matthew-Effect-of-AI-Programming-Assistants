(define (numOfSubarrays arr)
  (let loop ([i 0] [sum 0] [even 1] [odd 0] [res 0])
    (if (>= i (length arr))
        res
        (let* ([new-sum (+ sum (list-ref arr i))]
               [new-res (if (odd? new-sum) (+ res even) (+ res odd))])
          (loop (+ i 1)
                new-sum
                (if (even? new-sum) (+ even 1) even)
                (if (odd? new-sum) (+ odd 1) odd)
                new-res)))))