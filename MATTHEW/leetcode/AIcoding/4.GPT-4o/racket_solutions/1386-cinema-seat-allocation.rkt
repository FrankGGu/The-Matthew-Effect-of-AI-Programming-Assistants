(define (maxProfit n reservedSeats)
  (define (is-reserved? row seat)
    (let loop ((seats reservedSeats))
      (cond
        ((null? seats) #f)
        ((and (= (car (car seats)) row) (= (cdr (car seats)) seat)) #t)
        (else (loop (cdr seats))))))

  (define (can-book? row seats)
    (and (not (is-reserved? row 2))
         (not (is-reserved? row 3))
         (not (is-reserved? row 4))
         (not (is-reserved? row 5))
         (not (is-reserved? row 6))
         (not (is-reserved? row 8))
         (not (is-reserved? row 9))))

  (define (book-seats row)
    (if (can-book? row)
        (if (= row n) 0 4)
        (if (or (is-reserved? row 2) (is-reserved? row 3))
            (if (or (is-reserved? row 4) (is-reserved? row 5))
                (if (or (is-reserved? row 6) (is-reserved? row 8))
                    (if (is-reserved? row 9) 0 1)
                    2)
                1)
            0)))

  (define (loop row total)
    (if (> row n) total
        (loop (+ row 1) (+ total (book-seats row)))))

  (loop 1 0))

(maxProfit n reservedSeats)