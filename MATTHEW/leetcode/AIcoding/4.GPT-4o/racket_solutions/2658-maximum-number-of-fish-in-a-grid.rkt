(define (max-fish grid)
  (define rows (length grid))
  (define cols (length (first grid)))
  (define (dfs r c)
    (if (or (< r 0) (>= r rows) (< c 0) (>= c cols) (= (list-ref (list-ref grid r) c) 0))
        0
        (let ((fish (list-ref (list-ref grid r) c)))
          (set! (list-ref (list-ref grid r) c) 0)
          (+ fish (dfs (+ r 1) c) (dfs (- r 1) c) (dfs r (+ c 1)) (dfs r (- c 1)))))))

  (define (find-max)
    (for/sum ([r (in-range rows)]
               [c (in-range cols)])
      (let ((fish (list-ref (list-ref grid r) c)))
        (if (> fish 0)
            (dfs r c)
            0))))

  (find-max))