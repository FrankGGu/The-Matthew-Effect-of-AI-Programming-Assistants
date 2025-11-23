(define (count-covered-buildings buildings)
  (define (covered? a b)
    (and (<= (car a) (car b)) (>= (cdr a) (cdr b))))

  (define (update-covered covered building)
    (define new-covered (filter (lambda (b) (not (covered? building b))) covered))
    (cons building new-covered))

  (define (count-covered-helper buildings covered)
    (if (null? buildings)
        (length covered)
        (count-covered-helper (cdr buildings) (update-covered covered (car buildings)))))

  (count-covered-helper (sort buildings (lambda (a b) (< (car a) (car b)))) '()))

)

(define buildings '((1 5) (2 3) (4 6) (7 8)))
(count-covered-buildings buildings)