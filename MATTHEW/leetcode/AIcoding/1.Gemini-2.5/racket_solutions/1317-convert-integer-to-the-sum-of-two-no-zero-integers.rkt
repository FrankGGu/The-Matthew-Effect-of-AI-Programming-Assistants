(define (no-zero? num)
  (not (string-contains? (number->string num) "0")))

(define (get-no-zero-integers n)
  (for/first ([a (in-range 1 n)])
    (let ([b (- n a)])
      (when (and (no-zero? a) (no-zero? b))
        (list a b)))))