(define (max-subsequence nums k)
  (let* ([n (length nums)]
         [indexed-nums (map (lambda (i v) (cons i v)) (range n) nums)]
         [sorted-nums (sort indexed-nums > #:key cdr)]
         [top-k (take sorted-nums k)]
         [indices (sort (map car top-k) <)]
         [result (map (lambda (i) (list-ref nums i)) indices)])
    result))