(define (split-array nums)
  (define (gcd a b)
    (if (= b 0) a (gcd b (remainder a b))))

  (define (prime-factors n)
    (let loop ((n n) (i 2) (factors '()))
      (cond
        [(> i (sqrt n)) (if (> n 1) (cons n factors) factors)]
        [(= (remainder n i) 0) (loop (/ n i) i (cons i factors))]
        [else (loop n (+ i 1) factors)])))

  (define (coprime? factors1 factors2)
    (empty? (intersect equal? factors1 factors2)))

  (define (solve nums)
    (let loop ((i 1) (left-factors '()) (right-factors (apply append (map prime-factors nums))))
      (cond
        [(= i (length nums)) -1]
        [else
         (let ((new-left-factors (apply append (map prime-factors (list (list-ref nums (- i 1))))))
               (new-right-factors (filter (lambda (x) (not (member x (apply append (map prime-factors (list (list-ref nums (- i 1)))))) )) right-factors)))
           (if (coprime? left-factors new-left-factors)
               (if (coprime? (append left-factors new-left-factors) new-right-factors)
                   (- i 1)
                   (loop (+ i 1) (append left-factors new-left-factors) new-right-factors)
                   )
               (loop (+ i 1) (append left-factors new-left-factors) new-right-factors)
               )
           )])))

  (solve nums))