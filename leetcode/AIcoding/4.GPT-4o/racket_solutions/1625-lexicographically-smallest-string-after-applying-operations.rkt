(define (lex-smallest-string s a b)
  (define (rotate str)
    (string-append (substring str 1) (substring str 0 1)))

  (define (apply-operations str)
    (if (string=? str (rotate str))
        str
        (apply-operations (rotate str))))

  (define (add-a str)
    (string-map (lambda (c) (if (= (char->integer c) (char->integer #\z)) #\a (integer->char (+ (char->integer c) a)))) str))

  (define (transform str)
    (if (= b 0)
        (apply-operations str)
        (let ((new-str (add-a str)))
          (min (apply-operations new-str) (apply-operations str)))))

  (transform s))

(lex-smallest-string "cba" 1 1)