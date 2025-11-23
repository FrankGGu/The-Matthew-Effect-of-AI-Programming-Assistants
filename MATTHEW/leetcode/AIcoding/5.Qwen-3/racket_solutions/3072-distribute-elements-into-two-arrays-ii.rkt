(define (sort-array-by-parity nums)
  (let loop ([nums nums] [even '()] [odd '()])
    (cond
      [(null? nums) (append even odd)]
      [(even? (car nums)) (loop (cdr nums) (cons (car nums) even) odd)]
      [else (loop (cdr nums) even (cons (car nums) odd))])))

(define (distribute-elements-into-two-arrays-ii nums)
  (define sorted (sort-array-by-parity nums))
  (define len (length sorted))
  (define half (quotient len 2))
  (define arr1 (take sorted half))
  (define arr2 (drop sorted half))
  (define sum1 (apply + arr1))
  (define sum2 (apply + arr2))
  (if (> sum1 sum2) sum1 sum2))