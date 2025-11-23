(define (maximum-odd-binary-number s)
  (define cnt (count #\1 s))
  (if (= cnt 0)
      "0"
      (string-append (make-string (- cnt 1) #\1) (make-string (- (string-length s) cnt) #\0) "1")))