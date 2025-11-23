(define (zero-filled-subarrays nums)
  (define (helper count res)
    (if (null? nums)
        res
        (let ((n (car nums)))
          (if (= n 0)
              (helper (+ count 1) (+ res count 1))
              (helper 0 res)))))
  (helper 0 0))