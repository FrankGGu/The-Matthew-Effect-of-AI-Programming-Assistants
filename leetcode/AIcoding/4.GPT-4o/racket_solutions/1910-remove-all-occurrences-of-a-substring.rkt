(define (removeOccurrences s part)
  (define (helper str)
    (let loop ((current str))
      (cond
        ((string-contains? current part) 
         (loop (string-replace current part "")))
        (else current))))
  (helper s))