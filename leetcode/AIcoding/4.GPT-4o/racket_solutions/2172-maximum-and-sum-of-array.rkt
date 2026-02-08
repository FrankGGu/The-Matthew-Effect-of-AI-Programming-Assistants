(define (maximum-and-sum nums)
  (define (helper nums mask)
    (if (null? nums)
        0
        (let* ((first (car nums))
               (and-value (bitwise-and first mask))
               (with (if (> and-value 0)
                         (+ and-value (helper (cdr nums) mask))
                         (helper (cdr nums) mask))))
          (max with (helper (cdr nums) (bitwise-ior mask (bitwise-and first mask)))))))
  (helper nums 0))

(define (maximumAndSum nums)
  (maximum-and-sum nums))