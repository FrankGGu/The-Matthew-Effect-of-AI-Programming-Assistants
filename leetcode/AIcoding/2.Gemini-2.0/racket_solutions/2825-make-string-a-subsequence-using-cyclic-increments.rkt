(define (solve s t)
  (let loop ([i 0] [j 0])
    (cond
      [(>= j (string-length t)) #t]
      [(>= i (string-length s)) #f]
      [else
       (let ([s-char (string-ref s i)]
             [t-char (string-ref t j)])
         (if (or (char=? s-char t-char)
                 (char=? (integer->char (+ 1 (char->integer s-char))) t-char)
                 (and (char=? s-char #\z) (char=? t-char #\a)))
             (loop (+ 1 i) (+ 1 j))
             (loop (+ 1 i) j)))])))

(define (is-subsequence-cyclic s t)
  (solve s t))