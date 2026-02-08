(define (maximum-odd-binary-number s)
  (let* ([ones (count (lambda (c) (equal? c #\1)) s)]
         [zeros (- (string-length s) ones)])
    (string-append (make-string (- ones 1) #\1)
                   (make-string zeros #\0)
                   "1")))