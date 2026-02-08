(define/contract (max-value n x)
  (-> string? exact-integer? string?)
  (define (insert-at s i c)
    (string-append (substring s 0 i) (string c) (substring s i (string-length s))))

  (define len (string-length n))
  (define (helper i)
    (cond
      [(= i len) (insert-at n len (integer->char (+ x 48)))]
      [(char<? (string-ref n i) (integer->char (+ x 48)))
       (if (char=? (string-ref n 0) #\-)
           (insert-at n i (integer->char (+ x 48)))
           (insert-at n i (integer->char (+ x 48))))]
      [else (helper (add1 i))]))

  (if (char=? (string-ref n 0) #\-)
      (helper 1)
      (helper 0)))