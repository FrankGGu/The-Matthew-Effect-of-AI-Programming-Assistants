(define (smallestMissingInteger nums)
  (define (helper nums prefix-sum)
    (let loop ((i 1) (j 0))
      (cond
        [(= j (length nums)) i]
        [(= i (list-ref nums j)) (loop (add1 i) (add1 j))]
        [(< i (list-ref nums j)) (loop (add1 i) j)])))
  (helper (sort nums <) 0))