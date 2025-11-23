(define (minCostToMakeArrayEqual n cost)
  (define (binary-search left right)
    (if (= left right)
        left
        (let* ((mid (quotient (+ left right) 2))
               (total-cost (apply + (map (lambda (x) (abs (- x mid))) (range 1 (+ n 1)))))))
          (if (< total-cost cost)
              (binary-search left mid)
              (binary-search (add1 mid) right)))))
  (binary-search 1 n))

(minCostToMakeArrayEqual 5 14)