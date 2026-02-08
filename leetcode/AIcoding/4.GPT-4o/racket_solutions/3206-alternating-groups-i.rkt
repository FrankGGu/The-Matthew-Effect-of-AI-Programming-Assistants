(define (alternatingGroups lst)
  (define (helper lst acc flip)
    (if (null? lst)
        (reverse acc)
        (let ((current (car lst))
              (rest (cdr lst)))
          (if flip
              (helper rest (cons current acc) (not flip))
              (helper rest acc (not flip))))))
  (helper lst '() #t))

(define (solve)
  (let ((input '(1 2 3 4 5 6 7 8 9 10)))
    (alternatingGroups input)))