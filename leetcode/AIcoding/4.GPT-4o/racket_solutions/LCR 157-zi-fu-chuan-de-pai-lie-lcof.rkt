(define (numOfWays nums)
  (define (factorial n)
    (if (= n 0)
        1
        (* n (factorial (- n 1)))))
  (define (comb n k)
    (if (< k 0)
        0
        (/ (factorial n) (* (factorial k) (factorial (- n k))))))
  (define n (length nums))
  (define total-ways (factorial n))
  (define (count-ways nums)
    (if (null? nums)
        1
        (let ([count (count (lambda (x) (equal? (car nums) x)) nums)])
          (* (comb (- n 1) (- count 1))
             (count-ways (filter (lambda (x) (not (equal? (car nums) x))) nums))))))
  (modulo (* total-ways (count-ways nums)) 1000000007))