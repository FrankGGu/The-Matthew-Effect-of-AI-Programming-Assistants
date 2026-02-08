(define (maximumOddBinaryNumber n)
  (define ones (sub1 (string-length n)))
  (define result (string-append (make-string ones #\1) "0"))
  result)