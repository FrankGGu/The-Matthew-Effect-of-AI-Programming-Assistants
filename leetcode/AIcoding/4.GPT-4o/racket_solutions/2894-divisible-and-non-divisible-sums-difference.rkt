(define (difference-of-sums arr x)
  (define divisible-sum (apply + (filter (lambda (n) (= (modulo n x) 0)) arr)))
  (define non-divisible-sum (apply + (filter (lambda (n) (not (= (modulo n x) 0))) arr)))
  (- divisible-sum non-divisible-sum))

(difference-of-sums arr x)