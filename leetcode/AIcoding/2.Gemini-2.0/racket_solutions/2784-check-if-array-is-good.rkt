(define (is-good nums)
  (define n (length nums))
  (if (= (length nums) 0)
      #f
      (let ((sorted-nums (sort nums <)))
        (and
         (= (last sorted-nums) (- n 1))
         (equal? (take sorted-nums (- n 1)) (build-list (- n 1) values))
         (equal? (list (last sorted-nums) (last sorted-nums)) (drop sorted-nums (- n 1)))))))