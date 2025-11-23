(define (minimum-absolute-difference arr)
  (let* ([sorted-arr (sort arr <)]
         [n (length sorted-arr)])
    (if (< n 2)
        '()
        (let-values ([(min-diff)
                      (for/fold ([current-min-diff +inf.0])
                                ([i (in-range 1 n)])
                        (let ([diff (abs (- (list-ref sorted-arr i) (list-ref sorted-arr (- i 1))))])
                          (min current-min-diff diff)))])
          (for/list ([i (in-range 1 n)]
                     #:when (= (abs (- (list-ref sorted-arr i) (list-ref sorted-arr (- i 1)))) min-diff))
            (list (list-ref sorted-arr (- i 1)) (list-ref sorted-arr i)))))))