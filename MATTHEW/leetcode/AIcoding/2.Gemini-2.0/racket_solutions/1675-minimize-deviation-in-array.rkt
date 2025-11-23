(define (minimumDeviation nums)
  (define s (set))
  (for ([n nums])
    (set-add! s (if (odd? n) n (* n 2))))

  (define (helper s min-dev)
    (if (empty? s)
        min-dev
        (let* ([max-val (apply max (set->list s))]
               [min-val (apply min (set->list s))]
               [new-min-dev (min min-dev (- max-val min-val))])
          (if (even? max-val)
              (helper (set-remove s max-val) (set-add! s (/ max-val 2)) new-min-dev)
              new-min-dev))))

  (helper s +inf.0))