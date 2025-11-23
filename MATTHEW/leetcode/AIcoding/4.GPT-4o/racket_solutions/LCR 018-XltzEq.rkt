(define (isPalindrome s)
  (define (is-alphanumeric? c)
    (or (and (>= c #\0) (<= c #\9))
        (and (>= c #\a) (<= c #\z))
        (and (>= c #\A) (<= c #\Z))))

  (define filtered (filter is-alphanumeric? (string->list (string-downcase s))))
  (equal? filtered (reverse filtered)))

(isPalindrome "A man, a plan, a canal: Panama")  ; Example test