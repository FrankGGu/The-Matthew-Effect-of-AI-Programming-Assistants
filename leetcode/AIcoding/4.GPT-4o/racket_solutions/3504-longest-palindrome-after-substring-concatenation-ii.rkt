(define (longestPalindrome str)
  (define (is-palindrome s)
    (equal? s (string-reverse s)))

  (define (count-palindrome s)
    (define n (string-length s))
    (for/fold ([count 0]) ([i (in-range n)])
      (if (is-palindrome (substring s 0 (+ i 1)))
          (+ count 1)
          count)))

  (define (helper left right)
    (if (>= left right)
        0
        (max (helper left (+ right 1))
             (count-palindrome (substring str left (+ right 1)))
             (helper (+ left 1) right))))

  (helper 0 (- (string-length str) 1)))

(longestPalindrome "your_input_string_here")