(define (check-if-can-break s1 s2)
  (define (break? a b)
    (let loop ((a-lst (sort (string->list a) char<=?))
               (b-lst (sort (string->list b) char<=?)))
      (cond
        ((null? a-lst) #t)
        ((char<=? (car a-lst) (car b-lst)) (loop (cdr a-lst) (cdr b-lst)))
        (else #f))))
  (or (break? s1 s2) (break? s2 s1)))