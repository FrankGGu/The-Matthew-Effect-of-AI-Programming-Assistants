(define (distribute-elements nums)
  (define a '())
  (define b '())
  (define (helper nums)
    (cond
      [(empty? nums) (values (reverse a) (reverse b))]
      [else
       (let ([x (car nums)])
         (cond
           [(or (empty? a) (>= x (car a))))
           (set! a (cons x a))
           [else
            (set! b (cons x b))])
         (helper (cdr nums)))])
    )
  (helper nums))

(define (distribute-elements-into-two-arrays nums)
  (let-values ([(a b) (distribute-elements nums)])
    (append a b)))