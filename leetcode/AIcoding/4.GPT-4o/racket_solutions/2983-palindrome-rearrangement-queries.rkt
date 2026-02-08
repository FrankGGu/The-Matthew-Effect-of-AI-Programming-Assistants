(define (can-rearrange-to-palindrome s)
  (define frequency (make-hash))
  (for-each (lambda (char)
              (hash-update! frequency char (lambda (x) (add1 (or x 0))) 1))
            (string->list s))
  (define odd-count (hash-count (lambda (k v) (odd? v)) frequency))
  (<= odd-count 1))

(define (palindrome-queries queries)
  (map can-rearrange-to-palindrome queries))

(palindrome-queries '("aabb" "abc" "civic" "ivicc" "hello"))