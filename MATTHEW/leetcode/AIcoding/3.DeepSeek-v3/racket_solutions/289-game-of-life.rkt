(define (game-of-life board)
  (let* ([rows (length board)]
         [cols (if (zero? rows) 0 (length (car board)))]
         [directions '((-1 -1) (-1 0) (-1 1)
                       (0 -1)          (0 1)
                       (1 -1)  (1 0)  (1 1))])
    (define (count-live-neighbors r c)
      (for/sum ([dir directions])
        (let ([nr (+ r (first dir))]
              [nc (+ c (second dir))])
          (if (and (>= nr 0) (< nr rows) (>= nc 0) (< nc cols))
              (if (= (list-ref (list-ref board nr) nc) 1) 1 0)
              0))))
    (define (next-state r c)
      (let ([live-neighbors (count-live-neighbors r c)]
            [current (list-ref (list-ref board r) c)])
        (cond
          [(= current 1)
           (if (or (< live-neighbors 2) (> live-neighbors 3)) 0 1)]
          [else
           (if (= live-neighbors 3) 1 0)])))
    (for/list ([r (in-range rows)])
      (for/list ([c (in-range cols)])
        (next-state r c)))))