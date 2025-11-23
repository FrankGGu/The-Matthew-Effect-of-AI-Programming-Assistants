(define (find-unique-number nums)
  (let loop ((nums (sort nums <))
             (i 0))
    (cond
      ((null? nums) i)
      ((= i (car nums)) (loop (cdr nums) (+ i 1)))
      (else i))))

(find-unique-number)