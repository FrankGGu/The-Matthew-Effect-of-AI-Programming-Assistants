(define (count-vowel-strings n)
  (define (helper n k)
    (if (= n 1)
        k
        (helper (sub1 n) (+ k (* (add1 k) 2) (* (add1 k) 3) (* (add1 k) 4) (* (add1 k) 5)))))
  (helper n 5))