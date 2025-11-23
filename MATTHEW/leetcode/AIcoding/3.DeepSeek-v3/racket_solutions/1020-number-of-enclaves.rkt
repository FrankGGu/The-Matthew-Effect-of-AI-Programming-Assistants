(define (num-enclaves grid)
  (let* ([m (length grid)]
         [n (if (zero? m) 0 (length (car grid)))]
         [visited (make-hash)]
         [directions '((0 1) (1 0) (0 -1) (-1 0))])

    (define (dfs i j)
      (hash-set! visited (cons i j) #t)
      (for ([dir directions])
        (let ([ni (+ i (car dir))]
              [nj (+ j (cadr dir))])
          (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n) 
                     (not (hash-ref visited (cons ni nj) #f))
                     (= (list-ref (list-ref grid ni) nj) 1))
            (dfs ni nj)))))

    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (or (zero? i) (= i (sub1 m)) (zero? j) (= j (sub1 n)))
          (when (and (= (list-ref (list-ref grid i) j) 1) 
                      (not (hash-ref visited (cons i j) #f)))
            (dfs i j)))))

    (let ([count 0])
      (for ([i (in-range m)])
        (for ([j (in-range n)])
          (when (and (= (list-ref (list-ref grid i) j) 1) 
                     (not (hash-ref visited (cons i j) #f)))
            (set! count (add1 count)))))
      count)))