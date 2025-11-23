(define (max-sum-with-exactly-k-elements nums k)
  (define sorted-nums (sort nums >))
  (apply + (take sorted-nums k)))