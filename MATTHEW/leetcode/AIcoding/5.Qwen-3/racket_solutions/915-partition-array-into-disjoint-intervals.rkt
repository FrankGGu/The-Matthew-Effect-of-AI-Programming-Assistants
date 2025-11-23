(define (partition-array nums)
  (let loop ([i 0] [max-so-far 0] [partition-point 0])
    (if (= i (length nums))
        partition-point
        (let ([current (list-ref nums i)])
          (if (> current max-so-far)
              (loop (+ i 1) current i)
              (loop (+ i 1) max-so-far partition-point))))))