(define (get-permutation n k)
  (define (factorial n)
    (if (= n 0)
        1
        (* n (factorial (- n 1)))))

  (define (find-digit digits k)
    (let* ([index (quotient k (factorial (length digits - 1)))]
           [digit (list-ref digits index)]
           [remaining-digits (remove digit digits)])
      (values digit (remainder k (factorial (length digits - 1))) remaining-digits)))

  (let loop ([digits (range 1 (+ n 1))] [k (- k 1)] [result '()])
    (if (null? digits)
        (string-append* (map number->string result))
        (let-values ([(digit new-k remaining-digits) (find-digit digits k)])
          (loop remaining-digits new-k (append result (list digit)))))))