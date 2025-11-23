(define (max-coins piles)
  (define (sort-piles)
    (sort piles >))
  (define sorted-piles (sort-piles))
  (define (helper i res)
    (if (>= i (length sorted-piles))
        res
        (helper (+ i 2) (+ res (list-ref sorted-piles (+ i 1))))))
  (helper 0 0))