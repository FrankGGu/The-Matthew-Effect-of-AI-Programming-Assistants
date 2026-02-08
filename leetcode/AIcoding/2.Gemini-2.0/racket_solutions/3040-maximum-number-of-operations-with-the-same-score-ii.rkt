(define (maxOperations nums)
  (define (solve l r score)
    (cond
      [(>= l r) 0]
      [else
       (let ([op1 (if (= (+ (list-ref nums l) (list-ref nums (+ l 1))) score)
                       (+ 1 (solve (+ l 2) r score))
                       0)]
             [op2 (if (= (+ (list-ref nums l) (list-ref nums r)) score)
                       (+ 1 (solve (+ l 1) (- r 1) score))
                       0)]
             [op3 (if (= (+ (list-ref nums (- r 1)) (list-ref nums r)) score)
                       (+ 1 (solve l (- r 2) score))
                       0)])
         (max op1 op2 op3)))]))

  (let ([n (length nums)])
    (max (solve 0 (- n 1) (+ (list-ref nums 0) (list-ref nums 1)))
         (solve 0 (- n 1) (+ (list-ref nums 0) (list-ref nums (- n 1))))
         (solve 0 (- n 1) (+ (list-ref nums (- n 2)) (list-ref nums (- n 1)))))))