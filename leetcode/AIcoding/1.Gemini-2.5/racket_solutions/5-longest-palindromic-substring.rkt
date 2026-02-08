#lang racket

(define (longest-palindrome s)
  (define n (string-length s))

  (if (zero? n)
      ""
      (begin
        (define current-start 0)
        (define max-len 1)

        (define (check-palindrome left right)
          (let loop ((l left) (r right))
            (if (and (>= l 0) (< r n) (char=? (string-ref s l) (string-ref s r)))
                (loop (- l 1) (+ r 1))
                (let ((current-palindrome-len (- r l 1)))
                  (when (> current-palindrome-len max-len)
                    (set! max-len current-palindrome-len)
                    (set! current-start (+ l 1)))))))

        (for ([i (in-range n)])
          (check-palindrome i i) ; Odd length palindromes (center s[i])
          (when (< (+ i 1) n)
            (check-palindrome i (+ i 1)))) ; Even length palindromes (center between s[i] and s[i+1])

        (substring s current-start (+ current-start max-len)))))