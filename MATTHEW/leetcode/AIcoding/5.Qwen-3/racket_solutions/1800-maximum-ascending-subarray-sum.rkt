(define (max-ascending-sum nums)
  (define (loop i current max-sum)
    (if (= i (length nums))
        max-sum
        (let ((num (list-ref nums i)))
          (if (> num (add1 (list-ref nums (- i 1))))
              (loop (+ i 1) num (max max-sum num))
              (loop (+ i 1) (+ current num) (max max-sum (+ current num))))))
    )
  (if (null? nums)
      0
      (loop 1 (list-ref nums 0) (list-ref nums 0))))