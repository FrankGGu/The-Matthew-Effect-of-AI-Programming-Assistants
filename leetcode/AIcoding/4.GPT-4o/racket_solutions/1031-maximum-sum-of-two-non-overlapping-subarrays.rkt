(define (max-sum-two-no-overlap nums first-len second-len)
  (define (max-sum arr len)
    (let loop ((i 0) (sum 0) (max-sum 0))
      (if (>= i (length arr))
          max-sum
          (let* ((new-sum (if (< i len)
                             (+ sum (list-ref arr i))
                             (+ sum (list-ref arr i) (- (list-ref arr (- i len)) (if (= i len) 0 (list-ref arr (- i len))))))
                             ))
                 (new-max-sum (max max-sum new-sum)))
            (loop (+ i 1) new-sum new-max-sum)))))

  (define sum-first (max-sum nums first-len))
  (define sum-second (max-sum nums second-len))

  (define (calculate max-sum1 max-sum2)
    (let loop ((i 0) (first-sum 0) (second-sum 0) (max 0))
      (if (>= i (length nums))
          max
          (let* ((new-first-sum (if (< i first-len)
                                     (+ first-sum (list-ref nums i))
                                     (+ first-sum (list-ref nums i) (- (list-ref nums (- i first-len)) (if (= i first-len) 0 (list-ref nums (- i first-len))))))
                                     ))
                 (new-second-sum (if (< (+ i 1) (+ first-len second-len))
                                     second-sum
                                     (+ second-sum (list-ref nums (+ i 1)) (- (list-ref nums (- (+ i 1) second-len)) (if (= (+ i 1) second-len) 0 (list-ref nums (- (+ i 1) second-len))))))
                                     ))
                 (new-max (max max (+ new-first-sum new-second-sum))))
            (loop (+ i 1) new-first-sum new-second-sum new-max)))))

  (max (calculate sum-first sum-second) (calculate sum-second sum-first)))