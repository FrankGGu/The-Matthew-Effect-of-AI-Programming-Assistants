(define (first-palindrome words)
  (define (is-palindrome? s)
    (let ((n (string-length s)))
      (let loop ((i 0) (j (- n 1)))
        (cond
          ((>= i j) #t)
          ((not (char=? (string-ref s i) (string-ref s j))) #f)
          (else (loop (+ i 1) (- j 1)))))))

  (cond
    ((null? words) "")
    ((is-palindrome? (car words)) (car words))
    (else (first-palindrome (cdr words)))))