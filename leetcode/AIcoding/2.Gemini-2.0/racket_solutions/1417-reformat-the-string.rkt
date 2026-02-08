(define (reformat-string s)
  (define digits (filter char-numeric? (string->list s)))
  (define letters (filter char-alphabetic? (string->list s)))
  (define (reformat d l acc)
    (cond
      [(empty? d) (if (empty? l) (list->string acc) #f)]
      [(empty? l) (if (empty? d) (list->string acc) #f)]
      [else (reformat (cdr d) (cdr l) (append acc (list (car d) (car l))))]))
  (cond
    [(> (length digits) (+ 1 (length letters))) #f]
    [(> (length letters) (+ 1 (length digits))) #f]
    [(equal? (length digits) (length letters)) (or (and (reformat digits letters '()) => list->string) (and (reformat letters digits '()) => list->string))]
    [(> (length digits) (length letters)) (list->string (foldl (lambda (d acc) (cons d (if (empty? acc) '() (cons (car acc) (cdr acc))))) (reverse letters) digits))]
    [else (list->string (foldl (lambda (l acc) (cons l (if (empty? acc) '() (cons (car acc) (cdr acc))))) (reverse digits) letters))]))