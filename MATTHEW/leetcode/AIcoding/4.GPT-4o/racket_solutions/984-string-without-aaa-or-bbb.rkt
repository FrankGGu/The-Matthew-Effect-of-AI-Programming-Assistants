(define (strWithout3a3b A B)
  (define (helper a b)
    (cond
      ((= a 0) (make-string b #\b))
      ((= b 0) (make-string a #\a))
      ((> a b)
       (if (>= a 2)
           (string-append "aa" (helper (- a 2) (- b 1)))
           (string-append "a" (helper (- a 1) b))))
      (else
       (if (>= b 2)
           (string-append "bb" (helper (- a 1) (- b 2)))
           (string-append "b" (helper a (- b 1)))))))
  (helper A B))