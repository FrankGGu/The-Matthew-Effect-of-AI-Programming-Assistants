(define (countDistinctColors balls)
  (length (remove-duplicates balls)))

(define (numDistinctColors balls)
  (countDistinctColors balls))