(define (interpret command)
  (let loop ([s command] [acc '()])
    (cond
      [(empty? s) (list->string (reverse acc))]
      [(string=? (substring s 0 1) "G") (loop (substring s 1) (cons "G" acc))]
      [(string=? (substring s 0 2) "()") (loop (substring s 2) (cons "o" acc))]
      [(string=? (substring s 0 4) "(al)") (loop (substring s 4) (cons "l" (cons "a" acc)))])))