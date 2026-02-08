(define (sum-zero n)
  (cond [(even? n) (append (for/list ([i (in-range 1 (+ (/ n 2) 1))]) i)
                           (for/list ([i (in-range 1 (+ (/ n 2) 1))]) (- i)))]
        [else (append (list 0) (for/list ([i (in-range 1 (+ (/ (- n 1) 2) 1))]) i)
                           (for/list ([i (in-range 1 (+ (/ (- n 1) 2) 1))]) (- i)))]))