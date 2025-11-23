(define (first-missing-positive nums)
  (let* ((n (length nums)))
    (for/list ((i (in-range n)))
      (cond
        ((<= (list-ref nums i) 0) (list-set nums i 1))
        (else (list-ref nums i))))
    (for/list ((i (in-range n)))
      (let ((val (abs (list-ref nums i))))
        (cond
          ((<= val n)
           (cond
             ((> (list-ref nums (- val 1)) 0)
              (list-set nums (- val 1) (- (list-ref nums (- val 1)))))
             ((= (list-ref nums (- val 1)) 0)
              (list-set nums (- val 1) (- n 1)))))
          (else (list-ref nums i)))))
    (let loop ((i 0))
      (cond
        ((= i n) (+ n 1))
        ((> (list-ref nums i) 0) (+ i 1))
        (else (loop (+ i 1)))))))