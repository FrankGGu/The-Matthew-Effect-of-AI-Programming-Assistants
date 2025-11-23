(define (monotone-increasing-digits n)
  (define s (number->string n))
  (define l (string-length s))
  (define (helper i)
    (cond
      [(>= i l) s]
      [(and (> i 0) (char<=? (string-ref s (- i 1)) (string-ref s i))) (helper (+ i 1))]
      [(> i 0)
       (define prev-char (string-ref s (- i 1)))
       (define new-prev-char (integer->char (- (char->integer prev-char) 1)))
       (define new-s (string-copy s))
       (string-set! new-s (- i 1) new-prev-char)
       (for ([j (in-range i l)])
         (string-set! new-s j #\9))
       (helper 0)
       ]
      [else s]))

  (string->number (helper 0)))