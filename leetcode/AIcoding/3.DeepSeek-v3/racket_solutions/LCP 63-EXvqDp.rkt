(define (find-ball grid)
  (define rows (vector-length grid))
  (define cols (if (zero? rows) 0 (vector-length (vector-ref grid 0))))
  (define result (make-vector cols -1))

  (define (dfs r c)
    (cond
      [(= r rows) c]
      [(< c 0) -1]
      [(>= c cols) -1]
      [else
       (let ([current (vector-ref (vector-ref grid r) c)])
       (cond
         [(= current 1)
          (if (or (= c (sub1 cols)) (= (vector-ref (vector-ref grid r) (add1 c)) -1))
              -1
              (dfs (add1 r) (add1 c)))]
         [else
          (if (or (= c 0) (= (vector-ref (vector-ref grid r) (sub1 c)) 1))
              -1
              (dfs (add1 r) (sub1 c)))])]))

  (for ([c (in-range cols)])
    (vector-set! result c (dfs 0 c)))
  result)
)