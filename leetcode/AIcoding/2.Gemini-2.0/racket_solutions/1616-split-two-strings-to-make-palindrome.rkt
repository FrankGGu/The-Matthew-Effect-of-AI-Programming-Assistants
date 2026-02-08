(define (check-palindrome s)
  (let loop ([i 0] [j (- (string-length s) 1)])
    (cond
      [(>= i j) #t]
      [(= (string-ref s i) (string-ref s j)) (loop (+ i 1) (- j 1))]
      [else #f])))

(define (check-concatenation a b)
  (let* ([n (string-length a)]
         [i (for/first ([i (in-range n)]
                        #:when (not (= (string-ref a i) (string-ref b (- n i 1)))))
             i)])
    (or (check-palindrome (substring a i (- n i)))
        (check-palindrome (substring b i (- n i))))))

(define (check-palindrome-formation a b)
  (or (check-concatenation a b)
      (check-concatenation b a)))

(provide check-palindrome-formation)