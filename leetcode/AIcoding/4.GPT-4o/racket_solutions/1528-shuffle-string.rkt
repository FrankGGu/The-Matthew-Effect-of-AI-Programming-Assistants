(define (restore-string s indices)
  (define (shuffle-helper s indices)
    (if (null? indices)
        ""
        (string-append (string-ref s (car indices)) (shuffle-helper s (cdr indices)))))
  (shuffle-helper s indices))

(define (shuffle-string s indices)
  (restore-string s indices))