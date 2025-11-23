(define (min-max-game nums)
  (let loop ([nums nums])
    (cond
      [(= (length nums) 1) (car nums)]
      [else
       (let ([new-nums '()])
         (for ([i (quotient (length nums) 2)])
           (if (even? i)
               (set! new-nums (cons (min (list-ref nums (* 2 i)) (list-ref nums (+ (* 2 i) 1))) new-nums))
               (set! new-nums (cons (max (list-ref nums (* 2 i)) (list-ref nums (+ (* 2 i) 1))) new-nums))))
         (loop (reverse new-nums)))])))