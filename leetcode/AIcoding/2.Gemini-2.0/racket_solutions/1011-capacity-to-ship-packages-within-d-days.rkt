(define (ship-within-days weights days)
  (define (possible-capacity capacity)
    (let loop ([current-weight 0] [days-needed 1] [remaining-weights weights])
      (cond
        [(empty? remaining-weights) #t]
        [(> (+ current-weight (car remaining-weights)) capacity)
         (if (> days-needed days)
             #f
             (loop (car remaining-weights) (+ days-needed 1) (cdr remaining-weights)))]
        [else (loop (+ current-weight (car remaining-weights)) days-needed (cdr remaining-weights))])))

  (define (binary-search low high)
    (cond
      [(>= low high) low]
      [else
       (let ([mid (floor (+ low high) 2)])
         (if (possible-capacity mid)
             (binary-search low mid)
             (binary-search (+ mid 1) high)))]))

  (let ([total-weight (apply + weights)]
        [max-weight (apply max weights)])
    (binary-search max-weight total-weight)))