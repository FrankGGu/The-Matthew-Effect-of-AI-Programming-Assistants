(define (find-max-fish grid)
  (define rows (length grid))
  (if (zero? rows) 0
      (define cols (length (car grid)))
      (define visited (make-vector (* rows cols) #f))
      (define (dfs r c)
        (if (or (< r 0) (>= r rows) (< c 0) (>= c cols)
            0
            (if (or (vector-ref visited (+ (* r cols) c)) (zero? (list-ref (list-ref grid r) c)))
                0
                (begin
                  (vector-set! visited (+ (* r cols) c) #t)
                  (+ (list-ref (list-ref grid r) c)
                     (dfs (add1 r) c)
                     (dfs (sub1 r) c)
                     (dfs r (add1 c))
                     (dfs r (sub1 c)))))))
      (define max-fish 0)
      (for ([r (in-range rows)])
        (for ([c (in-range cols)])
          (define fish (dfs r c))
          (when (> fish max-fish)
            (set! max-fish fish))))
      max-fish))