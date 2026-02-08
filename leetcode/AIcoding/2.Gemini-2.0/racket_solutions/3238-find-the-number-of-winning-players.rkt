(define (find-winners matches)
  (define wins (make-hash))
  (define losses (make-hash))

  (for ([match (in-list matches)])
    (define winner (first match))
    (define loser (second match))

    (hash-update! wins winner (λ (v) (+ v 1)) 0)
    (hash-update! losses loser (λ (v) (+ v 1)) 0))

  (define no-loss-players
    (sort (filter (λ (player) (not (hash-has-key? losses player))) (hash-keys wins)) <))

  (define one-loss-players
    (sort (filter (λ (player) (and (hash-has-key? losses player) (= (hash-ref losses player) 1))) (hash-keys losses)) <))

  (list no-loss-players one-loss-players))