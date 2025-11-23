(define (my-atoi s)
  (define (trim s)
    (string-trim s))

  (define (is-digit ch)
    (and (char? ch) (char<=? #\0 ch #\9)))

  (define (char-to-int ch)
    (- (char->integer ch) (char->integer #\0)))

  (define (parse s)
    (define sign (if (string-prefix? "-" s) -1 1))
    (define start (if (or (string-prefix? "-" s) (string-prefix? "+" s)) 1 0))
    (define len (string-length s))
    (define result 0)
    (for ([i (in-range start len)])
      (when (is-digit (string-ref s i))
        (set! result (+ (* result 10) (char-to-int (string-ref s i))))))
    (* sign result))

  (define trimmed (trim s))
  (if (string=? trimmed "")
      0
      (parse trimmed)))