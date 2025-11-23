(define/contract (has-valid-path grid)
  (-> (listof (listof exact-integer?)) boolean?)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))
  (define visited (make-hash))

  (define (dfs i j)
    (cond
      [(and (= i (sub1 m)) (= j (sub1 n))) #t]
      [(hash-ref visited (cons i j) #f) #f]
      [else
       (hash-set! visited (cons i j) #t)
       (let ([street (list-ref (list-ref grid i) j)])
         (define next-dirs
           (case street
             [(1) '((0 1) (0 -1))]
             [(2) '((1 0) (-1 0))]
             [(3) '((0 -1) (1 0))]
             [(4) '((0 1) (1 0))]
             [(5) '((-1 0) (0 -1))]
             [(6) '((-1 0) (0 1))]))
         (for/or ([dir next-dirs])
           (let ([ni (+ i (car dir))]
                 [nj (+ j (cadr dir))])
             (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                  (let ([next-street (list-ref (list-ref grid ni) nj)])
                    (define opposite-dir (map - dir))
                    (member opposite-dir
                            (case next-street
                              [(1) '((0 1) (0 -1))]
                              [(2) '((1 0) (-1 0))]
                              [(3) '((0 -1) (1 0))]
                              [(4) '((0 1) (1 0))]
                              [(5) '((-1 0) (0 -1))]
                              [(6) '((-1 0) (0 1))]))
                    (dfs ni nj))))))]))

  (dfs 0 0))