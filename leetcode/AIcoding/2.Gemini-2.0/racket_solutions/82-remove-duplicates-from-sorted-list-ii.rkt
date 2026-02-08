(define (delete-duplicates lst)
  (cond
    [(null? lst) '()]
    [(null? (cdr lst)) lst]
    [(= (car lst) (cadr lst))
     (let loop ([l (cdr lst)] [v (car lst)])
       (cond
         [(null? l) '()]
         [(= (car l) v) (loop (cdr l) v)]
         [else (delete-duplicates l)]))]
    [else (cons (car lst) (delete-duplicates (cdr lst)))]))