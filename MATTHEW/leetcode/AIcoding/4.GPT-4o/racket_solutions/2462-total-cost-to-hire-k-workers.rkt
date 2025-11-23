(define (totalCost costs k candidates)
  (define (helper costs k candidates)
    (if (zero? k)
        0
        (let* ((n (length costs))
               (sorted-costs (sort costs <))
               (current-cost (if (<= (length sorted-costs) candidates)
                                  (car sorted-costs)
                                  (apply min sorted-costs))))
          (+ current-cost (helper (remove (lambda (x) (= x current-cost)) costs) (- k 1) candidates)))))
  (helper costs k candidates))

(define (minCostToHireWorkers costs k candidates)
  (totalCost costs k candidates))