(define (maximum-odd-binary-number s)
  (let* ([count-1 (count (lambda (c) (char=? c #\1)) (string->list s))]
         [count-0 (- (string-length s) count-1)]
         [result (string-append (make-string (- count-1 1) #\1)
                                (make-string count-0 #\0)
                                "1")])
    (if (zero? count-1) "0" result)))