(define (punishment-number n)
  (define (can-partition-sum? s target current-index current-sum)
    (cond
      ((= current-index (string-length s))
       (= current-sum target))
      ((> current-sum target)
       #f)
      (else
       (for/or ([j (in-range current-index (string-length s))])
         (let* ([sub-str (substring s current-index (+ j 1))]
                [num (string->number sub-str)])
           (can-partition-sum? s target (+ j 1) (+ current-sum num)))))))

  (for/sum ([i (in-range 1 (+ n 1))]
            #:when (can-partition-sum? (number->string (* i i)) i 0 0))
    i))