(define (validMountainArray arr)
  (define n (length arr))
  (if (< n 3) #f
      (let loop ((i 1) (up #f) (down #f))
        (cond
          ((= i n) (and up down))
          ((and (not up) (< (list-ref arr i) (list-ref arr (- i 1)))) (not down) (loop (add1 i) up #t))
          ((and (not down) (> (list-ref arr i) (list-ref arr (- i 1)))) (loop (add1 i) #t down))
          ((and up down) (loop (add1 i) up down))
          (else #f))))))