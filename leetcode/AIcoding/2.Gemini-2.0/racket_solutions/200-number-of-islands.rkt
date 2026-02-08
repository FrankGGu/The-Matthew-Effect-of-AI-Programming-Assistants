(define (numIslands grid)
  (define rows (length grid))
  (define cols (if (zero? rows) 0 (length (first grid))))

  (define (isValid r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c)
    (when (and (isValid r c) (equal? (list-ref (list-ref grid r) c) '1))
      (set! (list-ref (list-ref grid r) c) '0)
      (dfs (+ r 1) c)
      (dfs (- r 1) c)
      (dfs r (+ c 1))
      (dfs r (- c 1))))

  (define (solve)
    (let loop ((r 0) (c 0) (count 0))
      (cond
        ((>= r rows) count)
        ((>= c cols) (loop (+ r 1) 0 count))
        ((equal? (list-ref (list-ref grid r) c) '1)
         (dfs r c)
         (loop r (+ c 1) (+ count 1)))
        (else (loop r (+ c 1) count)))))

  (solve))