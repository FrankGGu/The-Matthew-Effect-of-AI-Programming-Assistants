(define (countSubstrings s)
  (define (expandAroundCenter left right)
    (define count 0)
    (while (and (>= left 0) (< right (string-length s)) 
                (char=? (string-ref s left) (string-ref s right)))
      (set! count (+ count 1))
      (set! left (- left 1))
      (set! right (+ right 1)))
    count)

  (define total 0)
  (for ([i (in-range (string-length s))])
    (set! total (+ total (expandAroundCenter i i))) ; odd length palindromes
    (set! total (+ total (expandAroundCenter i (+ i 1))))) ; even length palindromes
  total)