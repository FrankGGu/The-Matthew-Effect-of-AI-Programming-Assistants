(define (count-beautiful-numbers n)
  (define (is-beautiful? x)
    (let loop ((num x) (count 0))
      (cond
        [(= num 0) (zero? count)]
        [(= (remainder num 10) 0) (loop (quotient num 10) (add1 count))]
        [else (loop (quotient num 10) count)])))
  (define (counting-beautiful from to)
    (if (> from to) 0
        (+ (if (is-beautiful? from) 1 0) 
           (counting-beautiful (add1 from) to))))
  (counting-beautiful 1 n))

(define (countBeautifulNumbers n)
  (count-beautiful-numbers n))