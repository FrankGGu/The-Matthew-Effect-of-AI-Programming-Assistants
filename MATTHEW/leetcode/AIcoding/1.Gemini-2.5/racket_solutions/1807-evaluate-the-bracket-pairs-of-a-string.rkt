(define (evaluate s knowledge)
  (define h (make-hash))
  (for-each (lambda (pair)
              (hash-set! h (car pair) (cadr pair)))
            knowledge)

  (define result-parts '())
  (define current-key-chars '())
  (define in-bracket #f)

  (for ([i (in-range (string-length s))])
    (define char (string-ref s i))
    (cond
      [(char=? char #\()
       (set! in-bracket #t)
       (set! current-key-chars '())]
      [(char=? char #\))
       (set! in-bracket #f)
       (define key (list->string (reverse current-key-chars)))
       (define value (hash-ref h key "?"))
       (set! result-parts (cons value result-parts))]
      [in-bracket
       (set! current-key-chars (cons char current-key-chars))]
      [else
       (set! result-parts (cons (string char) result-parts))]))

  (apply string-append (reverse result-parts)))