(define (is-ugly n)
  (cond
    ((<= n 0) #f)
    (else
     (let loop ((current-n n))
       (cond
         ((= current-n 1) #t)
         ((zero? (modulo current-n 2)) (loop (quotient current-n 2)))
         ((zero? (modulo current-n 3)) (loop (quotient current-n 3)))
         ((zero? (modulo current-n 5)) (loop (quotient current-n 5)))
         (else #f))))))