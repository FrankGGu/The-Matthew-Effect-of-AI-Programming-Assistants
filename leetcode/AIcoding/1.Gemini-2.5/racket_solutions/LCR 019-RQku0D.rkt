(define (check-palindrome s l r)
  (let loop ((l l) (r r))
    (cond
      ((>= l r) #t)
      ((char=? (string-ref s l) (string-ref s r))
       (loop (+ l 1) (- r 1)))
      (else #f))))

(define (valid-palindrome s)
  (let* ((n (string-length s)))
    (let loop ((l 0) (r (- n 1)))
      (cond
        ((>= l r) #t)
        ((char=? (string-ref s l) (string-ref s r))
         (loop (+ l 1) (- r 1)))
        (else
         (or (check-palindrome s (+ l 1) r)
             (check-palindrome s l (- r 1))))))))