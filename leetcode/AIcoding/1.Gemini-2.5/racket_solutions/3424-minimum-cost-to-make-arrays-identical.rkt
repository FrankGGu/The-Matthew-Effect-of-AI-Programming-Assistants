(define (min-cost-to-make-arrays-identical nums cost)
  ;; 1. Combine nums and cost into a list of pairs (num . cost)
  (define num-cost-pairs (map (lambda (n c) (cons n c)) nums cost))

  ;; 2. Sort the pairs based on the 'num' value in ascending order
  (define sorted-pairs (sort num-cost-pairs (lambda (a b) (< (car a) (car b)))))

  ;; 3. Calculate the total sum of all costs
  (define total-cost-sum (for/sum ([pair sorted-pairs]) (cdr pair)))

  ;; 4. Find the weighted median (target value x)
  ;; The weighted median is the num value where the cumulative cost sum
  ;; reaches or exceeds half of the total cost sum.
  (define median-val
    (let loop ([pairs sorted-pairs] [current-sum 0])
      (let* ([pair (car pairs)]
             [num (car pair)]
             [c (cdr pair)]
             [new-sum (+ current-sum c)])
        (if (>= (* new-sum 2) total-cost-sum)
            num ; Found the median value
            (loop (cdr pairs) new-sum)))))) ; Continue searching

  ;; 5. Calculate the total minimum cost using the determined median-val
  (for/sum ([pair sorted-pairs])
    (define num (car pair))
    (define c (cdr pair))
    (* (abs (- num median-val)) c)))