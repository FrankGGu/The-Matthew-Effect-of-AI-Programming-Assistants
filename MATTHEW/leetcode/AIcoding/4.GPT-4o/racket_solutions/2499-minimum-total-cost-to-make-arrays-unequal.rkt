(define (minimumTotalCost nums cost)
  (define n (length nums))
  (define (helper i total)
    (if (>= i n)
        total
        (let loop ((j i) (new-total total))
          (if (>= j n)
              new-total
              (loop (+ j 1) (if (and (not (= (list-ref nums i) (list-ref nums j)))
                                   (not (= 0 (list-ref cost j))))
                             (+ new-total (list-ref cost j))
                             new-total))))))
  (helper 0 0))

(define (minCost nums cost)
  (minimumTotalCost nums cost))