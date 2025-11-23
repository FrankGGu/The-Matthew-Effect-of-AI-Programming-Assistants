(define (closed-island grid)
  (define rows (length grid))
  (define cols (length (first grid)))

  (define (is-valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c)
    (cond
      [(not (is-valid? r c)) #f]
      [(zero? (list-ref (list-ref grid r) c))
       (set! (list-ref (list-ref grid r) c) 1)
       (and (dfs (add1 r) c)
            (dfs (sub1 r) c)
            (dfs r (add1 c))
            (dfs r (sub1 c)))]
      [else #t]))

  (for/list ([r (in-range rows)])
    (set! (list-ref (list-ref grid r) 0) 1)
    (set! (list-ref (list-ref grid r) (- cols 1)) 1))

  (for/list ([c (in-range cols)])
    (set! (list-ref (list-ref grid 0) c) 1)
    (set! (list-ref (list-ref grid (- rows 1)) c) 1))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (and (zero? (list-ref (list-ref grid r) c))
                 (or (= r 0) (= r (- rows 1))
                     (= c 0) (= c (- cols 1))))
        (dfs r c))))

  (define count 0)
  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (zero? (list-ref (list-ref grid r) c))
        (when (dfs r c)
          (set! count (add1 count))))))
  count)