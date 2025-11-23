(define (isSelfCrossing distances)
  (define n (length distances))
  (cond
    [(< n 4) #f]
    [(and (>= (list-ref distances 3) (list-ref distances 1))
          (>= (list-ref distances 0) (+ (list-ref distances 2) (list-ref distances 4))))
     #t]
    [(and (>= (list-ref distances 2) (list-ref distances 0))
          (>= (list-ref distances 3) (list-ref distances 1))
          (>= (list-ref distances 0) (+ (list-ref distances 2) (list-ref distances 4))))
     #t]
    [(and (>= (list-ref distances 2) (list-ref distances 0))
          (>= (list-ref distances 3) (list-ref distances 1))
          (>= (list-ref distances 4) (+ (list-ref distances 2) (list-ref distances 0))))
     #t]
    [(and (>= (list-ref distances 2) (list-ref distances 0))
          (>= (list-ref distances 3) (list-ref distances 1))
          (>= (list-ref distances 4) (+ (list-ref distances 2) (list-ref distances 0)))
          (>= (list-ref distances 1) (+ (list-ref distances 3) (list-ref distances 5))))
     #t]
    [else (isSelfCrossing (cdr distances))]))

(define (selfCrossing distances)
  (isSelfCrossing distances))