(define/contract (find-ball grid)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define result (make-list cols -1))

  (define (dfs r c)
    (cond
      [(= r rows) c]
      [(= c -1) -1]
      [else
       (let ([current (list-ref (list-ref grid r) c)])
         (cond
           [(= current 1)
            (if (or (= c (sub1 cols)) (= (list-ref (list-ref grid r) (add1 c)) -1))
                -1
                (dfs (add1 r) (add1 c)))]
           [(= current -1)
            (if (or (= c 0) (= (list-ref (list-ref grid r) (sub1 c)) 1))
                -1
                (dfs (add1 r) (sub1 c)))]))]))

  (for ([c (in-range cols)])
    (list-set! result c (dfs 0 c)))

  result)