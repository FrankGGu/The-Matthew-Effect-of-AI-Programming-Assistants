(define (count-digit-one n)
  (if (<= n 0)
      0
      (let loop ((power-of-10 1)
                 (total-ones 0))
        (if (> power-of-10 n)
            total-ones
            (let* ((next-power-of-10 (* power-of-10 10))
                   (quotient-val (quotient n next-power-of-10))
                   (remainder-val (remainder n next-power-of-10))
                   (digit-at-k (quotient remainder-val power-of-10)))
              (let ((current-ones (+ total-ones (* quotient-val power-of-10))))
                (cond
                  ((= digit-at-k 1)
                   (loop next-power-of-10 (+ current-ones (add1 (remainder remainder-val power-of-10)))))
                  ((> digit-at-k 1)
                   (loop next-power-of-10 (+ current-ones power-of-10)))
                  (else ; digit-at-k is 0
                   (loop next-power-of-10 current-ones)))))))))