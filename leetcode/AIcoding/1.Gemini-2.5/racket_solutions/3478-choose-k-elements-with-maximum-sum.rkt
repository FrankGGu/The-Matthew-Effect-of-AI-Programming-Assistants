(require racket/list)

(define (max-sum-of-k-elements nums k)
  (let* ((sorted-nums (sort nums >))
         (top-k-elements (take sorted-nums k)))
    (apply + top-k-elements)))