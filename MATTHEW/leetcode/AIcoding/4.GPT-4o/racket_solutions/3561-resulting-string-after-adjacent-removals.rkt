(define (removeAdjacent s)
  (define (helper s)
    (if (null? s)
        '()
        (let loop ((chars (string->list s)) (result '()))
          (cond
            ((null? chars) (list->string (reverse result)))
            ((and (not (null? result)) (equal? (car chars) (car result)))
             (loop (cdr chars) (cdr result)))
            (else (loop (cdr chars) (cons (car chars) result)))))))
  (helper s))

(define (removeDuplicates s)
  (removeAdjacent s))