(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (insert-greatest-common-divisors head)
  (cond
    [(null? head) head]
    [(null? (cdr head)) head]
    [else
     (let* ([next-node (cdr head)]
            [gcd-val (gcd (car head) (car next-node))]
            [new-node (list gcd-val)])
       (set-cdr! head (cons new-node (cdr head)))
       (insert-greatest-common-divisors (cdr (cdr head))))]))