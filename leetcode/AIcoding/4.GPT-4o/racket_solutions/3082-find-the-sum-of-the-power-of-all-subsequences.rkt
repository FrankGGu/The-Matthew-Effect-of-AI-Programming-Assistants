(define (sumOfPower nums)
  (define n (length nums))
  (define mod 1000000007)
  (define (mod-exp base exp)
    (if (= exp 0)
        1
        (mod (* base (mod-exp base (- exp 1))) mod)))
  (define (calculate-sum)
    (foldl (lambda (x acc)
             (mod (+ acc (* x (mod-exp 2 (- n 1)))) mod))
           0
           (sort nums <)))
  (calculate-sum))

(sumOfPower '(1 2 3))