(define (target-indices nums target)
  (let ((sorted-nums (sort nums <)))
    (for/list ([val sorted-nums]
               [idx (in-naturals 0)]
               #:when (= val target))
      idx)))