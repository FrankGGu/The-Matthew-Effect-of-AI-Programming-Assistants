(define (maximum-beauty array k)
  (define (helper arr left right current)
    (cond
      [(>= left (length arr)) current]
      [(> right (length arr)) current]
      [else
       (let* ([diff (- (list-ref arr right) (list-ref arr left))])
         (if (<= diff (* 2 k))
             (helper arr left (+ 1 right) (+ 1 current))
             (helper arr (+ 1 left) right (- current 1))))]))

  (let ([sorted-array (sort array <)])
    (helper sorted-array 0 0 0)))