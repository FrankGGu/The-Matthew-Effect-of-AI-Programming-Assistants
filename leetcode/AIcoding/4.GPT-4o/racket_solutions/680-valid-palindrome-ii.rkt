(define (valid-palindrome? s)
  (define (is-palindrome? s left right)
    (cond
      ((>= left right) #t)
      ((char=? (string-ref s left) (string-ref s right)) (is-palindrome? s (+ left 1) (- right 1)))
      (else #f)))

  (define (can-remove? s left right)
    (or (is-palindrome? s (+ left 1) right)
        (is-palindrome? s left (- right 1))))

  (can-remove? s 0 (- (string-length s) 1)))

(define (validPalindrome s)
  (valid-palindrome? s))