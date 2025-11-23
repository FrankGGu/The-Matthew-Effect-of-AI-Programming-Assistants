(define (min-operations nums)
  (define (helper nums res)
    (if (null? nums)
        res
        (let ((n (car nums)))
          (if (= n 0)
              (helper (cdr nums) res)
              (helper (cdr nums) (+ res n))))))
  (helper nums 0))