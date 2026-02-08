(define (make-good s)
  (let loop ([chars (string->list s)] [stack '()])
    (cond
      [(null? chars) (list->string (reverse stack))]
      [(and (not (null? stack))
            (let ([c1 (car chars)] [c2 (car stack)])
            (or (and (char-upper-case? c1) (char-lower-case? c2) (char=? (char-downcase c1) c2))
                (and (char-lower-case? c1) (char-upper-case? c2) (char=? (char-upcase c1) c2)))
       (loop (cdr chars) (cdr stack))]
      [else (loop (cdr chars) (cons (car chars) stack))])))