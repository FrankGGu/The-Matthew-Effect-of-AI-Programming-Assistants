(define (can-reach arr start)
  (define n (vector-length arr))
  (define visited (make-vector n #f))

  (define (dfs i)
    (cond
      [(or (< i 0) (>= i n) (vector-ref visited i)) #f]
      [(zero? (vector-ref arr i)) #t]
      [else
       (vector-set! visited i #t)
       (or (dfs (+ i (vector-ref arr i)))
           (dfs (- i (vector-ref arr i))))]))

  (dfs start))