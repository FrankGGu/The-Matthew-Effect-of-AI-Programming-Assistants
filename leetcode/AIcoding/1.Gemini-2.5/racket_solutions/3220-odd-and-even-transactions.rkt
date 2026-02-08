(define (odd-even-transactions transactions)
  (define initial-sums (list 0 0))

  (foldl (lambda (transaction current-sums)
           (let* ((id (first transaction))
                  (amount (second transaction))
                  (odd-sum (first current-sums))
                  (even-sum (second current-sums)))
             (if (odd? id)
                 (list (+ odd-sum amount) even-sum)
                 (list odd-sum (+ even-sum amount)))))
         initial-sums
         transactions))