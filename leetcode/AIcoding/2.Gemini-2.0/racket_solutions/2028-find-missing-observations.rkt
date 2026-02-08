(define (missing-rolls rolls mean n k)
  (let* ((m (length rolls))
         (total-sum (* mean (+ n m)))
         (rolls-sum (apply + rolls))
         (missing-sum (- total-sum rolls-sum)))
    (if (or (< missing-sum n) (> missing-sum (* n 6)))
        '()
        (let loop ((i n) (remaining missing-sum) (acc '()))
          (cond
            ((= i 0) (reverse acc))
            (else
             (let* ((val (min 6 (quotient remaining i))))
               (loop (- i 1) (- remaining val) (cons val acc)))))))))