(define (make-good s)
  (let loop ([chars (string->list s)] [result '()])
    (cond
      [(empty? chars) (list->string (reverse result))]
      [(empty? result) (loop (cdr chars) (cons (car chars) result))]
      [else
       (let ([c (car chars)] [top (car result)])
         (if (and (char<> c top)
                  (equal? (char-upcase c) (char-upcase top)))
             (loop (cdr chars) (cdr result))
             (loop (cdr chars) (cons c result))))])))