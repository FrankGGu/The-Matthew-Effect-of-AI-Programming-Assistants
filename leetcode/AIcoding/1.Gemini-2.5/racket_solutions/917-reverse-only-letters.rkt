(define (reverse-only-letters s)
  (let* ([chars (string->list s)]
         [letters (filter char-alphabetic? chars)]
         [reversed-letters (reverse letters)]
         [reversed-letters-box (box reversed-letters)])

    (define (get-next-reversed-letter)
      (let ([current-letters (unbox reversed-letters-box)])
        (set-box! reversed-letters-box (cdr current-letters))
        (car current-letters)))

    (list->string
     (map (lambda (c)
            (if (char-alphabetic? c)
                (get-next-reversed-letter)
                c))
          chars))))