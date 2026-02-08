(define (is-prefix-of-array s words)
  (let loop ([prefix ""] [remaining-words words])
    (cond
      [(string=? prefix s) #t]
      [(null? remaining-words) #f]
      [else (let ([next-word (car remaining-words)])
              (let ([new-prefix (string-append prefix next-word)])
                (cond
                  [(string=? new-prefix s) #t]
                  [(string-prefix? s new-prefix) #f]
                  [(string-prefix? new-prefix s) (loop new-prefix (cdr remaining-words))]
                  [else #f])))])))