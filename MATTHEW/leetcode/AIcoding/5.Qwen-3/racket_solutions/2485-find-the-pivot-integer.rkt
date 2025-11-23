(define (pivot-integer n)
  (let loop ((i 1))
    (if (> i n)
        -1
        (let ((sum-i (* i (+ i 1) 1/2))
              (sum-n (* n (+ n 1) 1/2)))
          (if (= sum-i (- sum-n sum-i))
              i
              (loop (+ i 1)))))))