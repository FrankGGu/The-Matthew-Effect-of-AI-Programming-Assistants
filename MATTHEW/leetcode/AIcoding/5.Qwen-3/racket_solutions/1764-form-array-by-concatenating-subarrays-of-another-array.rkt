(define (can-form-array-1087-2 arr s)
  (define (helper i j)
    (cond [(= j (length s)) #t]
          [(= i (length arr)) #f]
          [else
           (let ([sub (take arr i)])
             (if (equal? sub (list-ref s j))
                 (helper (+ i (length sub)) (+ j 1))
                 (helper (+ i 1) j)))]))
  (helper 0 0))