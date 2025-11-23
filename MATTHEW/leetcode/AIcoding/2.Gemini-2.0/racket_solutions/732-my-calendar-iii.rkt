(define (my-calendar-iii)
  (let ([calendar (make-hash)])
    (define (book start end)
      (hash-update! calendar start (λ (v) (+ v 1)) 0)
      (hash-update! calendar end (λ (v) (- v 1)) 0)
      (define events (sort (hash-keys calendar) <))
      (define (max-overlapping events current-overlap max-overlap)
        (cond
          [(empty? events) max-overlap]
          [else
           (let* ([event (car events)]
                  [change (hash-ref calendar event)])
             (max-overlapping (cdr events) (+ current-overlap change) (max max-overlap (+ current-overlap change))))]))
      (max-overlapping events 0 0))
    (lambda (start end) (book start end))))