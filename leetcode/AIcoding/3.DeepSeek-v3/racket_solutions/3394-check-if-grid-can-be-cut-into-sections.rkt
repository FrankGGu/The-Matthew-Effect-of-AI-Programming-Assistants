#lang racket

(define (possible-to-cut grid)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))

  (define visited (make-hash))

  (define (dfs i j)
    (when (and (>= i 0) (< i m) (>= j 0) (< j n) 
               (equal? (list-ref (list-ref grid i) j) 1)
               (not (hash-ref visited (cons i j) #f)))
      (hash-set! visited (cons i j) #t)
      (dfs (add1 i) j)
      (dfs (sub1 i) j)
      (dfs i (add1 j))
      (dfs i (sub1 j))))

  (define (count-components)
    (hash-clear! visited)
    (define cnt 0)
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (and (equal? (list-ref (list-ref grid i) j) 1)
                   (not (hash-ref visited (cons i j) #f)))
          (set! cnt (add1 cnt))
          (dfs i j)))
    cnt)

  (define total (count-components))
  (if (zero? total)
      #t
      (for/or ([i (in-range m)])
        (for/or ([j (in-range n)])
          (when (equal? (list-ref (list-ref grid i) j) 1)
            (define new-grid (for/list ([row (in-range m)])
                              (for/list ([col (in-range n)])
                                (if (and (= row i) (= col j))
                                    0
                                    (list-ref (list-ref grid row) col)))))
            (define new-total (count-components new-grid))
            (> new-total total))))))