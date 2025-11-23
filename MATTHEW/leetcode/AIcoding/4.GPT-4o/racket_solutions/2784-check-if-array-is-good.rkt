(define (isGood arr)
  (define n (length arr))
  (define sorted-arr (sort arr <))
  (define expected (map (lambda (x) (if (= x n) (- x 1) x)) (range 1 (+ n 1))))
  (equal? sorted-arr expected))

(define (checkGoodArray arr)
  (isGood arr))