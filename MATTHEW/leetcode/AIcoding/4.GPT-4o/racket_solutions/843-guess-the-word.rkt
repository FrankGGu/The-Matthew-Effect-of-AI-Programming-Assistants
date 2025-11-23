(define (findSecretWord wordlist master)
  (define (match word1 word2)
    (length (filter (lambda (i) (char=? (string-ref word1 i) (string-ref word2 i))) (range 6)))
  )

  (define (guess-word candidate)
    (let ((count (master candidate)))
      (if (= count 6) (error "Found the secret word!"))))

  (define (helper words)
    (if (null? words) '()
      (let ((guess (car words)))
        (guess-word guess)
        (helper (filter (lambda (w) (= (match guess w) (master guess))) (cdr words))))))

  (helper wordlist))