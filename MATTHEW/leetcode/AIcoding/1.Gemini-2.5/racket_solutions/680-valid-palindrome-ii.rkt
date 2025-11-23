(define (is-palindrome-range s left right)
  (let loop ((l left) (r right))
    (cond
      ((>= l r) #t)
      ((char=? (string-ref s l) (string-ref s r))
       (loop (+ l 1) (- r 1)))
      (else #f))))

(define (valid-palindrome s)
  (let* ((n (string-length s)))
    (let loop ((left 0) (right (- n 1)))
      (cond
        ((>= left right) #t)
        ((char=? (string-ref s left) (string-ref s right))
         (loop (+ left 1) (- right 1)))
        (else
         (or (is-palindrome-range s (+ left 1) right)
             (is-palindrome-range s left (- right 1))))))))