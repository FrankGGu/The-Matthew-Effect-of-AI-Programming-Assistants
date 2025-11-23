(define (find-kth-largest nums k)
  (let* ((sorted-nums (sort nums <))
         (len (length sorted-nums)))
    (list-ref sorted-nums (- len k))))