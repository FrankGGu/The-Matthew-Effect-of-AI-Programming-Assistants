(define (percentage-letter s letter)
  (let* ((total (string-length s))
         (count (length (filter (lambda (c) (equal? c letter)) (string->list s)))))
    (/ (* count 100.0) total)))

(percentage-letter "foobar" #\o)