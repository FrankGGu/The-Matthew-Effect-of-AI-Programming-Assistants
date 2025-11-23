(define (reverseList head)
  (define (iter prev current)
    (if (null? current)
        prev
        (iter current (cdr current) (cons (car current) prev))))
  (iter '() head))