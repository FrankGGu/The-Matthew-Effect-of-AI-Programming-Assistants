(define (minArraySum nums)
  (define (helper nums acc)
    (if (null? nums)
        acc
        (helper (cdr nums) (+ acc (car nums)))))
  (helper nums 0))

(minArraySum (list 1 2 3 4))