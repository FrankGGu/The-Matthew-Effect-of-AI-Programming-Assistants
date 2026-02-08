(define (minMoves2 nums)
  (define (median lst)
    (let* ([sorted (sort lst <)]
           [n (length sorted)])
      (if (odd? n)
          (list-ref sorted (quotient n 2))
          (let ([mid1 (list-ref sorted (quotient n 2))]
                [mid2 (list-ref sorted (sub1 (quotient n 2)))])
            (floor (/ (+ mid1 mid2) 2.0)))))
  (define m (median nums))
  (apply + (map (lambda (x) (abs (- x m))) nums)))