(define (addToArrayForm num k)
  (define (num->list n)
    (if (zero? n)
        '()
        (cons (modulo n 10) (num->list (quotient n 10)))))

  (define (list->num lst)
    (foldl (lambda (x acc) (+ (* 10 acc) x)) 0 lst))

  (define (add-lists lst1 lst2 carry)
    (cond
      [(and (empty? lst1) (empty? lst2) (zero? carry)) '()]
      [(empty? lst1) (add-lists '() lst2 carry)]
      [(empty? lst2) (add-lists lst1 '() carry)]
      [else
       (let* ([sum (+ (car lst1) (car lst2) carry)]
              [digit (modulo sum 10)]
              [new-carry (quotient sum 10)])
         (cons digit (add-lists (cdr lst1) (cdr lst2) new-carry)))]))

  (define result (reverse (add-lists (reverse num) (reverse (num->list k)) 0)))
  result)