(define (is-prime n)
  (define (helper i)
    (cond
      [(= i (sqrt n)) #t]
      [(or (= n 1) (= n 0)) #f]
      [(= (modulo n i) 0) #f]
      [else (helper (+ i 1))]))
  (if (< n 2) #f (helper 2)))

(define (count-set-bits n)
  (let loop ((n n) (count 0))
    (if (= n 0)
        count
        (loop (arithmetic-shift-right n 1) (+ count (modulo n 2))))))

(define (prime-set-bits-in-range left right)
  (define (count-prime-bits n)
    (let ((set-bits (count-set-bits n)))
      (if (is-prime set-bits) 1 0)))
  (let loop ((i left) (total 0))
    (if (> i right)
        total
        (loop (+ i 1) (+ total (count-prime-bits i))))))

(prime-set-bits-in-range left right)