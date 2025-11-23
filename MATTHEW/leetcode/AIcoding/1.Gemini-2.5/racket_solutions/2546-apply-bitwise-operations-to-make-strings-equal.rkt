#lang racket

(define (check-string-for-char s char-to-find)
  (string-contains? s (string char-to-find)))

(define (make-strings-equal s target)
  (cond
    ((string=? s target) #t)
    (else
     (let ((s-has-zero (check-string-for-char s #\0))
           (s-has-one (check-string-for-char s #\1)))
       (and s-has-zero s-has-one)))))