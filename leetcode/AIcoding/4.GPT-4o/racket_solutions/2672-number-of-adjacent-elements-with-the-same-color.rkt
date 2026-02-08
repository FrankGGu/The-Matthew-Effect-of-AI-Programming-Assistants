(define (colorCount colors)
  (define (count-adjacent lst)
    (if (null? lst) 
        0 
        (if (and (cdr lst) (equal? (car lst) (cadr lst)))
            (+ 1 (count-adjacent (cdr lst)))
            (count-adjacent (cdr lst)))))
  (count-adjacent colors))

(define (numAdjacentColors colors)
  (colorCount colors))