(define (find-kth-largest nums k)
  (define sorted (sort nums >))
  (list-ref sorted (- k 1)))

(define (kthLargest nums k)
  (find-kth-largest nums k))