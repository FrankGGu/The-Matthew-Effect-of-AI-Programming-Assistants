(define (find-k-closest-elements arr k x)
  (define (abs-diff a b)
    (abs (- a b)))

  (define (compare a b)
    (cond [(< (abs-diff a x) (abs-diff b x)) -1]
          [(> (abs-diff a x) (abs-diff b x)) 1]
          [else (- a b)]))

  (define sorted-arr (sort arr compare))

  (take sorted-arr k))