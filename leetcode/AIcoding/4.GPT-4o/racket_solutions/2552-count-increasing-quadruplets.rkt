(define (countQuadruplets nums)
  (define n (length nums))
  (define count 0)
  (for* ([i (in-range n)]
         [j (in-range (+ i 1) n)]
         [k (in-range (+ j 1) n)]
         [l (in-range (+ k 1) n)])
    (when (and (> (list-ref nums i) (list-ref nums j))
               (> (list-ref nums j) (list-ref nums k))
               (> (list-ref nums k) (list-ref nums l)))
      (set! count (+ count 1))))
  count)

(countQuadruplets '(1 3 2 4 5)) ; Example usage