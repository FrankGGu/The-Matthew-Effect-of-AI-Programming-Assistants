(define (number-of-paths matrix k)
  (define m (vector-length matrix))
  (define n (vector-length (vector-ref matrix 0)))

  (define memo (make-hash))

  (define (dfs row col sum)
    (cond
      [(or (< row 0) (>= row m) (< col 0) (>= col n)) 0]
      [(= row (- m 1)) (= col (- n 1))
       (if (zero? (modulo (+ sum (vector-ref (vector-ref matrix row) col)) k)) 1 0)]
      [else
       (let ([key (list row col sum)])
         (if (hash-has-key? memo key)
             (hash-ref memo key)
             (let ([new-sum (modulo (+ sum (vector-ref (vector-ref matrix row) col)) k)])
               (let ([result (modulo (+ (dfs (+ row 1) col new-sum) (dfs row (+ col 1) new-sum)) 1000000007)])
                 (hash-set! memo key result)
                 result)))))]))

  (dfs 0 0 0))