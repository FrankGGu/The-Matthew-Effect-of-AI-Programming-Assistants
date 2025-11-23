(define (permutations nums)
  (cond
    ((empty? nums) (list '()))
    (else
     (apply append
            (for/list ((x nums))
              (let* ((rest (remove x nums))
                     (perms-of-rest (permutations rest)))
                (for/list ((p perms-of-rest))
                  (cons x p))))))))