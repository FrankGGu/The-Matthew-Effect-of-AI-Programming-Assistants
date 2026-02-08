(define (max-divisibility-score nums divisors)
  (let* ([scores (map (lambda (d)
                          (count (lambda (n) (= (remainder n d) 0)) nums))
                      divisors)]
         [max-score (apply max scores)]
         [candidates (filter (lambda (d s) (= s max-score))
                             divisors
                             scores)])
    (apply min candidates)))