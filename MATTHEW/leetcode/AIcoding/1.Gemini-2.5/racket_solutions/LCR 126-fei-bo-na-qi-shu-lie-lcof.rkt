(define (fib n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (else
     (let loop ((k 2) (a 0) (b 1))
       (if (= k n)
           (+ a b)
           (loop (+ k 1) b (+ a b)))))))