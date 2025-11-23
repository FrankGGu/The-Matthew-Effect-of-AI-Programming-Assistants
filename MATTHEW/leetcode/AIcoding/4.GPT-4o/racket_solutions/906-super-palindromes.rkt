(define (is-palindrome? n)
  (let ((s (number->string n)))
    (equal? s (string-reverse s))))

(define (is-super-palindrome? n)
  (and (is-palindrome? n)
       (is-palindrome? (* n n))))

(define (super-palindromes-in-range L R)
  (let loop ((i 1) (count 0))
    (if (> (expt i 2) R)
        count
        (let ((square (* i i)))
          (if (and (>= square L) (<= square R) (is-super-palindrome? i))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count))))))

(define (superPalindromesInRange L R)
  (let ((L (string->number L))
        (R (string->number R)))
    (super-palindromes-in-range (sqrt L) (sqrt R))))