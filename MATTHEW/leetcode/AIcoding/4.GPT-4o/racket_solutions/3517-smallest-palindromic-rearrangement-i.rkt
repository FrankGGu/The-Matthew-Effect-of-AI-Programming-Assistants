(define (smallestPalindrome s)
  (define freq (make-hash))
  (for ([char (in-string s)])
    (hash-set! freq char (+ 1 (hash-ref freq char 0))))
  (define odd-char #f)
  (define result "")
  (for ([char (in-list (sort (hash-keys freq) string<?))])
    (define count (hash-ref freq char 0))
    (if (odd? count)
      (begin
        (if (not odd-char)
            (set! odd-char char))
        (set! count (- count 1)))
    (set! result (string-append result (make-string (/ count 2) char)))))
  (define reversed (string-reverse result))
  (if odd-char
    (string-append result (string odd-char) reversed)
    (string-append result reversed)))

(define (smallestPalindromeWrapper s)
  (smallestPalindrome s))

(smallestPalindromeWrapper "aabb") ; should return "abba"