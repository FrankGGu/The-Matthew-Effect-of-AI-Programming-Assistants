#lang racket

(define (min-days grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))

  (define (count-islands grid)
    (define visited (make-hash))
    (define count 0)

    (define (dfs i j)
      (when (and (>= i 0) (< i rows) (>= j 0) (< j cols) 
                 (equal? (list-ref (list-ref grid i) j) 1)
                 (not (hash-ref visited (cons i j) #f)))
        (hash-set! visited (cons i j) #t)
        (dfs (add1 i) j)
        (dfs (sub1 i) j)
        (dfs i (add1 j))
        (dfs i (sub1 j))))

    (for ([i (in-range rows)])
      (for ([j (in-range cols)])
        (when (and (equal? (list-ref (list-ref grid i) j) 1)
                   (not (hash-ref visited (cons i j) #f)))
          (dfs i j)
          (set! count (add1 count)))))
    count)

  (define original-islands (count-islands grid))
  (if (not (= original-islands 1))
      0
      (begin
        (for ([i (in-range rows)])
          (for ([j (in-range cols)])
            (when (equal? (list-ref (list-ref grid i) j) 1)
              (define new-grid (for/list ([row grid]) (list-copy row)))
              (list-set! (list-ref new-grid i) j 0)
              (define islands (count-islands new-grid))
              (when (or (zero? islands) (> islands 1))
                (return 1)))))
        2)))