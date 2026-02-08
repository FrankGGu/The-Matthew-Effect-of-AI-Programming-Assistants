(define (kth-largest nums k)
  (define sorted-nums (sort nums >))
  (list-ref sorted-nums (- k 1)))