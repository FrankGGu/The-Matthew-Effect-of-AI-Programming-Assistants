(define (can-be-sorted? nums)
  (let loop ((i 0) (prev -inf.0) (swapped #f))
    (cond
      [(>= i (length nums)) #t]
      [(> (list-ref nums i) prev) (loop (add1 i) (list-ref nums i) swapped)]
      [swapped #f]
      [else (loop (add1 i) prev #t)])))