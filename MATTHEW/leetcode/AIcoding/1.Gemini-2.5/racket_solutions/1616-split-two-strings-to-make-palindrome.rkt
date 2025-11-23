#lang racket

(define (is-palindrome-substring s start end)
  (let loop ((l start) (r end))
    (cond
      ((>= l r) #t)
      ((char=? (string-ref s l) (string-ref s r))
       (loop (+ l 1) (- r 1)))
      (else #f))))

(define (check-palindrome-formation a b)
  (let* ((n (string-length a)))

    (define (check s1 s2)
      (let loop ((l 0) (r (- n 1)))
        (cond
          ((>= l r) #t)
          ((char=? (string-ref s1 l) (string-ref s2 r))
           (loop (+ l 1) (- r 1)))
          (else
           (or (is-palindrome-substring s1 l r)
               (is-palindrome-substring s2 l r))))))

    (or (check a b) (check b a))))