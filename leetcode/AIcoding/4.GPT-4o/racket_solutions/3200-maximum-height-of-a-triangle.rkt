(define (maximum-height-of-triangle A)
  (define (helper n)
    (if (<= n 0)
        0
        (max (helper (- n 1)) 
             (if (>= n (car A)) 
                 (1 + (helper (- n (car A)))) 
                 0))))
  (helper (length A)))

(maximum-height-of-triangle '(1 2 3))