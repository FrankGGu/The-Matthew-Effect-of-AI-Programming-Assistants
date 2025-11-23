(define (min-deletions nums nums-divisor)
  (define (list-gcd lst)
    (foldl gcd (car lst) (cdr lst)))

  (define common-divisor-target (list-gcd nums-divisor))

  (define sorted-nums (sort nums <))

  (define (find-smallest-dividing-element-index current-list current-index)
    (cond
      [(empty? current-list) -1]
      [(zero? (remainder common-divisor-target (car current-list)))
       current-index]
      [else
       (find-smallest-dividing-element-index (cdr current-list) (+ current-index 1))]))

  (find-smallest-dividing-element-index sorted-nums 0))