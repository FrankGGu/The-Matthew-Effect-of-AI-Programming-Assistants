(define (construct-the-minimum-bitwise-array-ii k)
  (cond
    ((= k 0) 0)
    (else
     (let* ((popcount (bitwise-popcount k))
            (lsb (bitwise-and k (- k))))
       (cond
         ((= popcount 1) k) ; k is a power of 2
         ((>= popcount 3) 0)
         ((= popcount 2)
          (cond
            ((or (= lsb 1) (= lsb 2)) 0)
            (else lsb))) ; lsb must be >= 4
         (else (error "Unexpected value of k or popcount")))))))