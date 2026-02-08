(define (minimumBeautifulSum(n))
  (define (helper n)
    (cond
      [(= n 0) 0]
      [(= n 1) 1]
      [(and (even? n) (not (= n 2))) (min (+ 1 (helper (/ n 2))) (+ 1 (helper (- n 1))))]
      [else (+ 1 (helper (- n 1)))]))
  (helper n))

(minimumBeautifulSum 15)