(define (count-set-bits n)
  (let loop ((n n) (count 0))
    (if (= n 0)
        count
        (loop (bitwise-and n (- n 1)) (+ count 1)))))

(define (is-prime n)
  (cond
    [(<= n 1) #f]
    [(= n 2) #t]
    [(even? n) #f]
    [else
     (let loop ((i 3))
       (cond
         [(> (* i i) n) #t]
         [(= (remainder n i) 0) #f]
         [else (loop (+ i 2))]))]))

(define (prime-set-bits left right)
  (let loop ((n left) (count 0))
    (if (> n right)
        count
        (loop (+ n 1) (+ count (if (is-prime (count-set-bits n)) 1 0))))))