(define (num-ways n x)
  (define (dp i rem)
    (cond
      [(= rem 0) 1]
      [(< rem 0) 0]
      [(= i 0) (if (= rem 0) 1 0)]
      [else (+ (dp (sub1 i) rem) (dp i (- rem (expt i x))))]))
  (dp n n))

(define (num-powers n)
  (let loop ((i 1) (count 0))
    (if (<= (expt i 1) n)
        (loop (add1 i) (add count (num-ways n i)))
        count)))

(define (powerSumWays n)
  (num-powers n))