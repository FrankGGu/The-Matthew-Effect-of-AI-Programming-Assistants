(define (min-operations nums)
  (define (helper nums count)
    (if (null? nums)
        count
        (let ((current (car nums)))
          (if (= current 1)
              (helper (cdr nums) count)
              (helper (cdr nums) (+ count 1))))))
  (helper nums 0))