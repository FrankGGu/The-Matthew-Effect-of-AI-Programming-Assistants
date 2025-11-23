(define/contract (max-number-of-families n reserved-seats)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define reserved (make-hash))
  (for ([seat reserved-seats])
    (hash-set! reserved (car seat) (cons (cadr seat) (hash-ref reserved (car seat) '()))))
  (define (count-empty row)
    (define seats (hash-ref reserved row '()))
    (define (available? s) (not (member s seats)))
    (define left (and (available? 2) (available? 3) (available? 4) (available? 5)))
    (define middle (and (available? 6) (available? 7) (available? 8) (available? 9)))
    (define right (and (available? 6) (available? 7) (available? 8) (available? 9)))
    (cond
      [(and left right) 2]
      [(or left middle right) 1]
      [else 0]))
  (let loop ([row 1] [result 0])
    (if (> row n)
        result
        (loop (add1 row) (+ result (count-empty row))))))