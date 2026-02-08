(define (max-length-between-equal-characters s)
  (let ((n (string-length s)))
    (let loop ((i 0) (max-len -1))
      (cond
        ((= i n) max-len)
        (else
         (let ((first-occurrence (string-ref s i)))
           (let loop2 ((j (sub1 n)))
             (cond
               ((< j i)
                (loop (add1 i) max-len))
               ((char=? (string-ref s j) first-occurrence)
                (loop (add1 i) (max max-len (- j i 1))))
               (else
                (loop2 (sub1 j)))))))))))