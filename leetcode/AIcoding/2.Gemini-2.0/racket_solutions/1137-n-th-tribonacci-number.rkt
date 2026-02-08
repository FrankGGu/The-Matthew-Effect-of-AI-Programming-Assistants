(define (tribonacci n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    ((= n 2) 1)
    (else
     (letrec ((trib (lambda (i a b c)
                      (if (= i n)
                          c
                          (trib (+ i 1) b c (+ a b c))))))
       (trib 3 0 1 1)))))