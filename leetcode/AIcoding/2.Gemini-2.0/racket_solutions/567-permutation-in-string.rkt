(define (check-inclusion s1 s2)
  (define (char->int c)
    (- (char->integer c) (char->integer #\a)))

  (define (count-chars s)
    (let ((counts (make-vector 26 0)))
      (for ([c (in-string s)])
        (vector-set! counts (char->int c) (+ 1 (vector-ref counts (char->int c)))))
      counts))

  (define s1-counts (count-chars s1))
  (define s1-len (string-length s1))
  (define s2-len (string-length s2))

  (if (> s1-len s2-len)
      #f
      (let loop ([i 0])
        (cond
          [(>= i (- s2-len s1-len -1)) #f]
          [else
           (let ((sub (substring s2 i (+ i s1-len))))
             (if (equal? s1-counts (count-chars sub))
                 #t
                 (loop (+ i 1))))]))))