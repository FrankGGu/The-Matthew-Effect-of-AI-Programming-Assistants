(define (min-sum-of-lengths arr target)
  (define n (length arr))
  (define prefix-sums (make-vector (+ n 1) 0))
  (for/fold ([i 0] #:result void) ([x (in-list arr)] [idx (in-naturals)])
    (vector-set! prefix-sums (+ idx 1) (+ x (vector-ref prefix-sums idx)))
    (set! i (+ i 1)))

  (define (find-min-length start end target)
    (let loop ([left start] [right end] [min-len #f])
      (cond
        [(> left right) min-len]
        [else
         (let* ([mid (quotient (+ left right) 2)]
                [sum (- (vector-ref prefix-sums (+ mid 1)) (vector-ref prefix-sums start))])
           (cond
             [(< sum target) (loop (+ mid 1) right min-len)]
             [(> sum target) (loop left (- mid 1) min-len)]
             [else (let ([new-len (+ mid 1 (- start))])
                     (loop left (- mid 1) (min (or min-len +inf.0) new-len)))]))]))))

  (define left-min-lengths (make-vector n +inf.0))
  (let loop ([i 0])
    (cond
      [(>= i n) void]
      [else
       (let ([len (find-min-length 0 i target)])
         (vector-set! left-min-lengths i (or len +inf.0)))
       (cond
         [(> i 0)
          (vector-set! left-min-lengths i (min (vector-ref left-min-lengths i) (vector-ref left-min-lengths (- i 1))))]
         [else #f])
       (loop (+ i 1))]))

  (define right-min-lengths (make-vector n +inf.0))
  (let loop ([i (- n 1)])
    (cond
      [(< i 0) void]
      [else
       (let ([len (find-min-length i (- n 1) target)])
         (vector-set! right-min-lengths i (or len +inf.0)))
       (cond
         [(< i (- n 1))
          (vector-set! right-min-lengths i (min (vector-ref right-min-lengths i) (vector-ref right-min-lengths (+ i 1))))]
         [else #f])
       (loop (- i 1))]))

  (let loop ([i 0] [min-sum +inf.0])
    (cond
      [(>= i (- n 1)) (if (equal? min-sum +inf.0) -1 min-sum)]
      [else
       (set! min-sum (min min-sum (+ (vector-ref left-min-lengths i) (vector-ref right-min-lengths (+ i 1)))))
       (loop (+ i 1) min-sum)])))