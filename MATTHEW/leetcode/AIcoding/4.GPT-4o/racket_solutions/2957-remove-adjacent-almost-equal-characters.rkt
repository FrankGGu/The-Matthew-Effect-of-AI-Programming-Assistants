(define (remove-adjacent-almost-equal s)
  (define (almost-equal? a b)
    (or (= (char->integer a) (char->integer b))
        (= (abs (- (char->integer a) (char->integer b))) 1)))

  (define (helper lst)
    (cond 
      ((null? lst) '())
      ((null? (cdr lst)) lst)
      ((almost-equal? (car lst) (cadr lst)) (helper (cdr lst)))
      (else (cons (car lst) (helper (cdr lst))))))

  (apply string (helper (map string->list (list s)))))