(define (robot-lexicographically-smallest s)
  (define (helper s n)
    (if (zero? n)
        ""
        (let* ([ch (string-ref s (- n 1))]
               [result (helper s (- n 1))])
          (if (or (equal? ch #\a) (and (equal? ch #\b) (not (string-contains? result #\a))))
              (string-append result (string ch))
              (string-append result (string-ref s (- n 2)))))))
  (helper s (string-length s)))

(define (using-robot-to-print-lexicographically-smallest-string s)
  (robot-lexicographically-smallest s))