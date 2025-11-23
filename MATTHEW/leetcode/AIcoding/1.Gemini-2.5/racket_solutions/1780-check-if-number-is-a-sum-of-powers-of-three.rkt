(define (check-powers-of-three n)
  (let loop ((current-n n))
    (cond
      ((zero? current-n) #t)
      ((= (remainder current-n 3) 2) #f)
      (else (loop (quotient current-n 3))))))