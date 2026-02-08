(define (min-deletions s)
  (let* ([freqs (make-hash)]
         [_ (for ([c (string->list s)])
              (hash-update! freqs c (λ (v) (+ v 1)) 1))]
         [freq-list (sort (hash-values freqs) >)]
         [deletions 0])
    (let loop ([remaining freq-list] [seen #()])
      (cond
        [(null? remaining) deletions]
        [else
         (let ([curr (car remaining)])
           (cond
             [(member? curr seen)
              (let loop2 ([curr curr])
                (cond
                  [(zero? curr) (loop (cdr remaining) seen)]
                  [(not (member? curr seen)) (loop (cdr remaining) (cons curr seen) (+ deletions (- (car remaining) curr)))]
                  [else (loop2 (- curr 1))]))]
             [else (loop (cdr remaining) (cons curr seen))]))]))))