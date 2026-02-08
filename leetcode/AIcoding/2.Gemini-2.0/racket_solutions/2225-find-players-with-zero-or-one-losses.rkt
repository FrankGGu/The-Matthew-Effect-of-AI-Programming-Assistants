(define (find-players-with-zero-or-one-losses matches)
  (define losses (make-hash))
  (for ([match matches])
    (let ([winner (car match)]
          [loser (cadr match)])
      (hash-update! losses winner (λ (v) v) 0)
      (hash-update! losses loser (λ (v) (+ v 1)) 1)))

  (define zero-loss-players (list))
  (define one-loss-players (list))

  (hash-for-each losses
                 (λ (player num-losses)
                   (cond
                     [(equal? num-losses 0) (set! zero-loss-players (cons player zero-loss-players))]
                     [(equal? num-losses 1) (set! one-loss-players (cons player one-loss-players))])))

  (list (sort zero-loss-players <) (sort one-loss-players <)))