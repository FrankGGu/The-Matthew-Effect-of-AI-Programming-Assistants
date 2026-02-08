(define (has-alternating-bits n)
  (let loop ((n n) (prev-bit #f))
    (cond
      ((zero? n) #t)
      (else
       (let ((current-bit (remainder n 2)))
         (if (and prev-bit (= current-bit prev-bit))
             #f
             (loop (quotient n 2) current-bit)))))))