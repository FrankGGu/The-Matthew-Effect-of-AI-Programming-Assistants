(define (num-tilings n)
  (define MOD 1000000007)
  (cond
    ((<= n 0) 0)
    ((= n 1) 1)
    ((= n 2) 2)
    (else
     (let loop ((i 3) (dp1 2) (dp2 1) (dp3 0))
       (if (> i n)
           dp1
           (let ((new-dp1 (modulo (+ dp1 dp2 (* 2 dp3)) MOD))
                 (new-dp3 (modulo (+ dp2 dp3) MOD)))
             (loop (+ i 1) new-dp1 dp1 new-dp3)))))))