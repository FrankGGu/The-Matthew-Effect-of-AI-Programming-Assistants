(define (numberOfBeams bank)
  (define (count-lasers row)
    (length (filter (lambda (x) (equal? x \1)) row)))

  (define (helper rows)
    (define prev 0)
    (define total 0)
    (for ([row rows])
      (define curr (count-lasers row))
      (when (> curr 0)
        (set! total (+ total (* prev curr)))
        (set! prev curr)))
    total)

  (helper bank))

(numberOfBeams '((0 0 1 0 0) (0 0 0 0 0) (0 1 0 0 1) (0 0 1 0 0)))