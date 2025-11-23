(define (distinct-prime-factors nums)
  (define (prime-factors n)
    (cond
      [(<= n 1) '()]
      [else
       (let loop ([i 2] [n n] [factors '()])
         (cond
           [(> i (sqrt n)) (if (> n 1) (cons n factors) factors)]
           [(= (remainder n i) 0) (loop i (/ n i) (cons i factors))]
           [else (loop (+ i 1) n factors)]))]))

  (define (union lst1 lst2)
    (foldl (lambda (x acc) (if (member x acc) acc (cons x acc))) lst1 lst2))

  (let loop ([nums nums] [factors '()])
    (cond
      [(empty? nums) factors]
      [else (loop (cdr nums) (union factors (prime-factors (car nums))))]))
  (length (loop nums '())))