#lang racket

(define (gcd-of-strings str1 str2)
  (if (not (string=? (string-append str1 str2) (string-append str2 str1)))
      ""
      (let* ((len1 (string-length str1))
             (len2 (string-length str2))
             (common-len (gcd len1 len2)))
        (substring str1 0 common-len))))