(define (can-convert s t)
  (define (next-char c)
    (if (= (char->integer c) 122)
        #\a
        (integer->char (+ (char->integer c) 1))))
  (define (is-subsequence s t)
    (let loop ((i 0) (j 0))
      (cond ((= j (string-length t)) #t)
            ((= i (string-length s)) #f)
            ((char=? (string-ref s i) (string-ref t j))
             (loop (+ i 1) (+ j 1)))
            (else
             (loop (+ i 1) j)))))
  (is-subsequence s t))