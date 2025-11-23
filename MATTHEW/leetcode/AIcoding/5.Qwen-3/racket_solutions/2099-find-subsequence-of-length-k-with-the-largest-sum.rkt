(define (min-k-length-subsequence nums k)
  (define (compare a b)
    (> (car a) (car b)))
  (define (sort-by-value lst)
    (sort lst compare))
  (define (get-indexes lst)
    (map cdr lst))
  (define (take-k lst k)
    (take lst k))
  (define (get-values lst indexes)
    (map (lambda (i) (list-ref lst i)) indexes))
  (define (find-subsequence nums k)
    (let* ([indexed-nums (map (lambda (i) (list (list-ref nums i) i)) (range (length nums)))]
           [sorted-nums (sort-by-value indexed-nums)]
           [top-k (take-k sorted-nums k)]
           [indexes (get-indexes top-k)]
           [values (get-values nums indexes)])
      (sort values <)))
  (find-subsequence nums k))