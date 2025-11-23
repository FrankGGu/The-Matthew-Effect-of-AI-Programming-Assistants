(define (second-highest s)
  (let loop ([digits '()] [chars (string->list s)])
    (cond
      [(null? chars)
       (cond
         [(< (length (remove-duplicates digits)) 2) -1
         (else (list-ref (sort (remove-duplicates digits) >) 1)))]]
      [(char-numeric? (car chars))
       (loop (cons (- (char->integer (car chars)) (char->integer #\0)) digits) (cdr chars))]
      [else (loop digits (cdr chars))])))