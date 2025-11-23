(define (pacific-atlantic matrix)
  (if (null? matrix)
      '()
      (let* ([m (length matrix)]
             [n (length (car matrix))]
             [pacific (make-hash)]
             [atlantic (make-hash)]
             [directions '((0 1) (1 0) (0 -1) (-1 0))])
        (define (dfs i j visited prev)
          (when (and (>= i 0) (< i m) (>= j 0) (< j n)
                 (not (hash-ref visited (cons i j) #f))
                 (>= (list-ref (list-ref matrix i) j) prev))
            (hash-set! visited (cons i j) #t)
            (for ([dir directions])
              (let ([ni (+ i (car dir))]
                    [nj (+ j (cadr dir))])
                (dfs ni nj visited (list-ref (list-ref matrix i) j))))))

        (for ([i (in-range m)])
          (dfs i 0 pacific -1)
          (dfs i (sub1 n) atlantic -1))
        (for ([j (in-range n)])
          (dfs 0 j pacific -1)
          (dfs (sub1 m) j atlantic -1))

        (for/list ([i (in-range m)]
                   #:when #t
                   [j (in-range n)]
                   #:when (and (hash-ref pacific (cons i j) #f)
                          (hash-ref atlantic (cons i j) #f))
          (list i j)))))