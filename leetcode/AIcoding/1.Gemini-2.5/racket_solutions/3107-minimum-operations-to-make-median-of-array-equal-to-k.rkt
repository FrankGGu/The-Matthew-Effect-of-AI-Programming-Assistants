(define (min-operations-to-make-median-equal-to-k nums k)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [mid-idx (quotient (- n 1) 2)])

    (+ (abs (- (list-ref sorted-nums mid-idx) k))
       (for/sum ([i (in-range 0 mid-idx)])
         (let ([val (list-ref sorted-nums i)])
           (if (> val k)
               (- val k)
               0)))
       (for/sum ([i (in-range (+ mid-idx 1) n)])
         (let ([val (list-ref sorted-nums i)])
           (if (< val k)
               (- k val)
               0))))))