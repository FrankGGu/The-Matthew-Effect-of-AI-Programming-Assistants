(define (find-words words)
  (define row1 (string->list "qwertyuiop"))
  (define row2 (string->list "asdfghjkl"))
  (define row3 (string->list "zxcvbnm"))

  (define (in-row? word row)
    (let loop ((chars (string->list (string-downcase word))))
      (cond
        [(null? chars) #t]
        [(member (car chars) row) (loop (cdr chars))]
        [else #f])))

  (define (filter-words words)
    (filter (lambda (word)
              (or (in-row? word row1)
                  (in-row? word row2)
                  (in-row? word row3)))
            words))

  (filter-words words))