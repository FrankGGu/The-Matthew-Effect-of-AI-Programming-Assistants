(define (min-increment-for-unique nums)
  (let* ([sorted-nums (sort nums <)])
    (for/fold ([operations 0]
               [expected-next 0])
              ([num sorted-nums])
      (if (< num expected-next)
          (values (+ operations (- expected-next num))
                  (+ expected-next 1))
          (values operations
                  (+ num 1))))))