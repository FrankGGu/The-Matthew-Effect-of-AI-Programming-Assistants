(define (longestSemiRepetitiveSubstring s)
  (define (is-semi-repetitive? substring)
    (let loop ((i 1) (count 0))
      (cond
        ((= i (string-length substring)) count)
        ((char=? (string-ref substring i) (string-ref substring (- i 1)))
         (loop (+ i 1) (if (= count 0) 1 count)))
        (else (loop (+ i 1) count)))))

  (define max-length 0)
  (define n (string-length s))

  (for* ((i (in-range n))
         (j (in-range (+ i 1) n)))
    (define sub (substring s i (+ j 1)))
    (when (= (is-semi-repetitive? sub) 1)
      (set! max-length (max max-length (string-length sub)))))

  max-length)

(longestSemiRepetitiveSubstring "abacaba")