(define (largest-palindrome-product n)
  (define (is-palindrome? num)
    (define str (number->string num))
    (string=? str (string-reverse str)))

  (define (find-largest-palindrome-product max-num min-num)
    (define (iter i j current-max)
      (cond
        [(< i min-num) current-max]
        [(< j min-num) (iter (- i 1) max-num current-max)]
        [else
         (let ((product (* i j)))
           (if (and (is-palindrome? product) (> product current-max))
               (iter i (- j 1) product)
               (iter i (- j 1) current-max)))
         ]))
    (iter max-num max-num 0))

  (let ((max-num (expt 10 n))
        (min-num (expt 10 (- n 1))))
    (modulo (find-largest-palindrome-product (- max-num 1) min-num) 1337)))