(define (minOperations nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (find-min-ops nums)
    (define target (foldl gcd (car nums) (cdr nums)))
    (define divisible? (lambda (x) (= (remainder x target) 0)))
    (if (not (divisible? 3))
        -1
        (let loop ((nums nums) (ops 0))
          (cond
            ((null? nums) -1)
            ((divisible? (car nums)) (loop (cdr nums) ops))
            (else (let ((ops1 (if (divisible? (- (car nums) 1)) (+ ops 1) +inf.0))
                        (ops2 (if (divisible? (- (car nums) 2)) (+ ops 1) +inf.0)))
                      (loop (cdr nums) (min ops1 ops2))))))))

  (find-min-ops nums))