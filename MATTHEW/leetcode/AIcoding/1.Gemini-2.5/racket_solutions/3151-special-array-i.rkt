(define (special-array nums)
  (let* ((n (length nums)))
    (let loop ((x 0))
      (if (> x n)
          -1
          (let ((count (for/sum ((num nums))
                         (if (>= num x) 1 0))))
            (if (= count x)
                x
                (loop (add1 x))))))))