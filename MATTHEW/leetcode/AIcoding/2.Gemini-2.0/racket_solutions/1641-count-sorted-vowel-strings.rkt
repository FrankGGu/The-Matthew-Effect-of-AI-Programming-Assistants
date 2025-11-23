(define (count-vowel-strings n)
  (cond
    [(zero? n) 0]
    [(= n 1) 5]
    [else (+ (count-vowel-strings (- n 1)) (count-vowel-strings-helper (- n 1) 4))]))

(define (count-vowel-strings-helper n k)
  (cond
    [(zero? n) 0]
    [(= n 1) (+ k 1)]
    [else (if (zero? k)
              1
              (+ (count-vowel-strings-helper n (- k 1)) (count-vowel-strings-helper (- n 1) k)))]))