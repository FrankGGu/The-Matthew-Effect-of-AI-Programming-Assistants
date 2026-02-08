(define (kth-smallest matrix k)
  (define (matrix-ref matrix i j)
    (list-ref (list-ref matrix i) j))

  (define n (length matrix))

  (define (count-less-equal val)
    (let loop ([i (- n 1)] [j 0] [count 0])
      (cond
        [(< i 0) count]
        [(>= j n) count]
        [(<= (matrix-ref matrix i j) val)
         (loop i (+ j 1) (+ count (+ i 1)))]
        [else
         (loop (- i 1) j count)])))

  (define (binary-search low high)
    (if (> low high)
        low
        (let* ([mid (floor (+ low high) 2)]
               [count (count-less-equal mid)])
          (cond
            [(>= count k) (binary-search low (- mid 1))]
            [else (binary-search (+ mid 1) high)]))))

  (binary-search (matrix-ref matrix 0 0) (matrix-ref matrix (- n 1) (- n 1))))