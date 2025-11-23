(define (count-substrings s)
  (let* ([n (string-length s)]
         [total-palindromes 0])

    (define (expand-and-count left right)
      (let loop ([l left] [r right] [count 0])
        (if (and (>= l 0)
                 (< r n)
                 (char=? (string-ref s l) (string-ref s r)))
            (loop (- l 1) (+ r 1) (+ count 1))
            count)))

    (for ([i (in-range n)])
      ;; Count palindromes with s[i] as the center (odd length)
      (set! total-palindromes (+ total-palindromes (expand-and-count i i)))

      ;; Count palindromes with s[i] and s[i+1] as centers (even length)
      (set! total-palindromes (+ total-palindromes (expand-and-count i (+ i 1)))))

    total-palindromes))