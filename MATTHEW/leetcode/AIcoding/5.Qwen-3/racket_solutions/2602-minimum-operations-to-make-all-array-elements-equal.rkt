(define (min-operations nums)
  (define (helper lst acc)
    (if (null? lst)
        acc
        (helper (cdr lst) (+ acc (abs (- (car lst) (car lst))))))
  )
  (let ((mid (list-ref nums (quotient (length nums) 2))))
    (apply + (map (lambda (x) (abs (- x mid))) nums)))
)