(define (power-of-heroes heroes)
  (define (helper lst)
    (if (null? lst)
        1
        (* (car lst) (helper (cdr lst)))))
  (helper heroes))

(define (maxPower heroes)
  (define (power-hero hero)
    (if (null? hero)
        0
        (max (car hero) (power-hero (cdr hero)))))
  (power-hero heroes))