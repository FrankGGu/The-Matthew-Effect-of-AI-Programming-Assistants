(define (number-of-ways corridor)
  (define n (string-length corridor))
  (define seats (filter (lambda (c) (equal? c #\S)) (string->list corridor)))
  (define num-seats (length seats))
  (if (or (odd? num-seats) (zero? num-seats))
      0
      (let loop ([i 0] [count 0] [ways 1])
        (cond
          [(= i (- num-seats 2)) ways]
          [else
           (let ([first-seat-index (string-index corridor (list-ref seats i) 0)]
                 [second-seat-index (string-index corridor (list-ref seats (+ i 1)) 0)]
                 [next-first-seat-index (string-index corridor (list-ref seats (+ i 2)) 0)])
             (loop (+ i 2) 0 (modulo (* ways (+ 1 (- next-first-seat-index second-seat-index))) 1000000007))
             ))]
        )))