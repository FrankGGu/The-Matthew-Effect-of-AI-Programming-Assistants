(define (diff-ways-to-add-parentheses expression)
  (cond [(string=? expression "") '()]
        [(not (member (string-ref expression 0) '(#\+ #\- \*))) (list (string->number expression))]
        [else
         (append-map (lambda (i)
                       (append (diff-ways-to-add-parentheses (substring expression 0 i))
                               (diff-ways-to-add-parentheses (substring expression (add1 i))))
                     (range 1 (string-length expression)))
         ]))