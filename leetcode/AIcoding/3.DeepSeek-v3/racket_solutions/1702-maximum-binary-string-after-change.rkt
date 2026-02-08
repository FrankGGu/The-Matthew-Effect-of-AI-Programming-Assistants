(define (maximum-binary-string binary)
  (let* ([n (string-length binary)]
         [zeros (count (lambda (c) (char=? c #\0)) binary)]
         [ones (- n zeros)])
    (if (<= zeros 1)
        binary
        (string-append (make-string (- zeros 1) #\1)
                       "0"
                       (make-string ones #\1)))))