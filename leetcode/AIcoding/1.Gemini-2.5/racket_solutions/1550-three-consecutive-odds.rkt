(define (three-consecutive-odds nums)
  (let loop ((lst nums) (odd-count 0))
    (cond
      ((>= odd-count 3) #t)
      ((null? lst) #f)
      ((odd? (car lst))
       (loop (cdr lst) (+ odd-count 1)))
      (else
       (loop (cdr lst) 0)))))