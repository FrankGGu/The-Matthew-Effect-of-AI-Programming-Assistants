(define (is-subsequence s t)
  (let* ((len-s (string-length s))
         (len-t (string-length t)))
    (let loop ((i 0) (j 0))
      (cond
        ((= i len-s) #true)
        ((= j len-t) #false)
        ((char=? (string-ref s i) (string-ref t j))
         (loop (+ i 1) (+ j 1)))
        (else
         (loop i (+ j 1)))))))