(define (check-palindrome-formation a b)
  (define (is-palindrome s i j)
    (let loop ([i i] [j j])
      (cond
        [(>= i j) #t]
        [(char=? (string-ref s i) (string-ref s j)) (loop (add1 i) (sub1 j))]
        [else #f])))

  (define (check a b)
    (let loop ([i 0] [j (sub1 (string-length a))])
      (cond
        [(>= i j) #t]
        [(char=? (string-ref a i) (string-ref b j)) (loop (add1 i) (sub1 j))]
        [else (or (is-palindrome a i j) (is-palindrome b i j))])))

  (or (check a b) (check b a)))