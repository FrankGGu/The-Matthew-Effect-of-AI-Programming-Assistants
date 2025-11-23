(define (min-deletions nums)
  (define (helper nums)
    (if (null? nums)
        0
        (let ((next (if (null? (cdr nums)) '() (cdr nums))))
          (if (and (not (null? next)) (= (car nums) (car next)))
              (add1 (helper next))
              (helper next)))))
  (helper (sort nums <)))