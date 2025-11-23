(define (check-string s)
  (let loop ((i 0))
    (cond
      ((= i (string-length s)) #t)
      ((char=? (string-ref s i) #\b) (for/fold ([result #t]) ([j (in-range (+ i 1) (string-length s))])
                                          (if (char=? (string-ref s j) #\a) #f result)))
      (else (loop (+ i 1))))))

(check-string "aaabbb")