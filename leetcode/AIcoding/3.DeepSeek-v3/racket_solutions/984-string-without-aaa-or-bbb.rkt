(define (str-without-3a3b a b)
  (define (helper a b a-char b-char)
    (if (< a b)
        (helper b a b-char a-char)
        (let loop ([res '()] [a a] [b b])
          (cond
            [(= a 0) (list->string (reverse res))]
            [(> a (+ b 1))
             (loop (cons a-char (cons a-char res)) (- a 2) b)]
            [(> a 0)
             (loop (cons a-char res) (- a 1) b)]
            [(> b 0)
             (loop (cons b-char res) a (- b 1))]))))
  (helper a b #\a #\b))