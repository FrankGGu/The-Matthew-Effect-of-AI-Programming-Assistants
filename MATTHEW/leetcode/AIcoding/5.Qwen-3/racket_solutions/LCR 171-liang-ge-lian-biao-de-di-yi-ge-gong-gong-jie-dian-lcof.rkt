(define (trainning-plan-v k)
  (define (helper n count)
    (if (> n k)
        count
        (let ((next (+ n (* n n))))
          (helper next (+ count 1)))))
  (helper 1 0))