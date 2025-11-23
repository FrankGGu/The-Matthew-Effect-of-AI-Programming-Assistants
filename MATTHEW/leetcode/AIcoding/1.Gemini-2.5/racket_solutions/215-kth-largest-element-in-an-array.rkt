(define (find-kth-largest nums k)
  (let* ((sorted-nums (sort nums <))
         (len (length nums)))
    (list-ref sorted-nums (- len k))))