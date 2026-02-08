(define (separate-squares n)
  (define (is-square? x)
    (let ((root (exact-integer-sqrt x)))
      (= (* root root) x)))

  (define (find-squares num)
    (cond
      [(= num 0) '()]
      [(< num 0) #f]
      [else
       (for/first ([i (in-range 1 (+ (exact-integer-sqrt num) 1))]
                   #:when (is-square? i))
         (let ([rest (- num i)])
           (define rest-squares (find-squares rest))
           (if rest-squares
               (cons i rest-squares)
               #f)))]))

  (let ([squares (find-squares n)])
    (if squares
        (length squares)
        0)))