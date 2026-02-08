(define (prisonAfterNDays cells n)
  (define (next-day cells)
    (map (lambda (i)
           (if (or (= i 0) (= i 7))
               0
               (if (= (list-ref cells (- i 1)) (list-ref cells (+ i 1)))
                   1
                   0)))
         (range 0 8)))
  (define (simulate cells n)
    (if (= n 0)
        cells
        (simulate (next-day cells) (- n 1))))
  (simulate cells n))