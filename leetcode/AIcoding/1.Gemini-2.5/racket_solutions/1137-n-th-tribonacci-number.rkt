(define (tribonacci n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    ((= n 2) 1)
    (else
     (let loop ((i 3) (t0 0) (t1 1) (t2 1))
       (if (= i n)
           (+ t0 t1 t2)
           (loop (+ i 1) t1 t2 (+ t0 t1 t2)))))))