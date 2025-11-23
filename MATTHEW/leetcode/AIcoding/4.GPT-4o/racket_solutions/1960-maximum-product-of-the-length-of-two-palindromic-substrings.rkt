(define (maxProduct palindromes)
  (define (is-palindrome s)
    (equal? s (string-reverse s)))
  (define (palindromic-substrings s)
    (let loop ((i 0) (j 0) (subs '()))
      (cond
        [(= i (string-length s)) subs]
        [(= j (string-length s)) (loop (+ i 1) (+ i 1) subs)]
        [(is-palindrome (substring s i j)) (loop i (+ j 1) (cons (substring s i j) subs))]
        [else (loop i (+ j 1) subs)])))

  (define palins (palindromic-substrings palindromes))
  (define max-product 0)

  (for ((i (in-range (length palins))))
    (for ((j (in-range i (length palins))))
      (when (not (equal? (list-ref palins i) (list-ref palins j)))
        (set! max-product (max max-product (* (string-length (list-ref palins i)) (string-length (list-ref palins j))))))))

  max-product)

(define (maxProductOfPalindromes s)
  (maxProduct s))