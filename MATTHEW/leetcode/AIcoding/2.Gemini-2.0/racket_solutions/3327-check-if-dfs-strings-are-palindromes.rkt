(define (is-palindrome? s)
  (equal? s (reverse s)))

(define (solve dfs-strings)
  (let loop ([strings dfs-strings]
             [palindromes '()])
    (cond
      [(null? strings) palindromes]
      [(is-palindrome? (car strings)) (loop (cdr strings) (cons #t palindromes))]
      [else (loop (cdr strings) (cons #f palindromes))])))

(define (check-dfs-strings dfs-strings)
  (solve dfs-strings))