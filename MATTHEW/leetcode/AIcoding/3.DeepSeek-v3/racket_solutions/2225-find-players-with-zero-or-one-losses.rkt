(define (find-winners matches)
  (define losses (make-hash))
  (for ([match matches])
    (define winner (car match))
    (define loser (cadr match))
    (hash-update! losses winner (lambda (x) x) 0)
    (hash-update! losses loser add1 0))

  (define no-losses '())
  (define one-loss '())

  (for ([(player loss-count) (in-hash losses)])
    (cond
      [(= loss-count 0) (set! no-losses (cons player no-losses))]
      [(= loss-count 1) (set! one-loss (cons player one-loss))]))

  (list (sort no-losses <) (sort one-loss <)))