(define (max-non-overlapping-palindromes s)
  (let* ([n (string-length s)]
         [dp (make-vector (add1 n) 0)]
         [is-palindrome? (lambda (i j)
                           (let loop ([l i] [r j])
                             (cond
                               [(>= l r) #t]
                               [else (and (char=? (string-ref s l) (string-ref s r))
                                           (loop (add1 l) (sub1 r)))])))]
    (for ([i (range 1 (add1 n))])
      (vector-set! dp i (vector-ref dp (sub1 i)))
      (for ([j (range 0 i)])
        (when (is-palindrome? j (sub1 i))
          (vector-set! dp i (max (vector-ref dp i)
                                 (add1 (vector-ref dp j)))))))
    (vector-ref dp n)))