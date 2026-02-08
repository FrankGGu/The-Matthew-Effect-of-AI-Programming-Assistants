(define (find-the-child n k)
  (if (= n 1)
      0
      (let* ((cycle-length (* 2 (- n 1)))
             (effective-k (remainder k cycle-length)))
        (if (< effective-k n)
            effective-k
            (- cycle-length effective-k)))))