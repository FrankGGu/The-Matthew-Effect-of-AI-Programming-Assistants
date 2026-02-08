(define (maximize-amount nums)
  (let ((n (length nums)))
    (let loop ((i 0) (amount 0) (converted-today #f) (converted-yesterday #f))
      (cond
        ((= i n) amount)
        (else
         (let ((not-convert (loop (+ i 1) amount converted-today converted-yesterday))
               (convert (if (and converted-today converted-yesterday)
                           -inf.0
                           (loop (+ i 1) (+ amount (if (or converted-today converted-yesterday)
                                                        (/ (list-ref nums i) 2)
                                                        (list-ref nums i)))
                                 #t
                                 converted-today))))
           (max not-convert convert)))))))