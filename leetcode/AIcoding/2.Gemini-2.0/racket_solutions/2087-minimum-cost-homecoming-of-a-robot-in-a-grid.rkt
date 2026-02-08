(define (min-cost-homecoming-robot
  start-pos
  home-pos
  row-costs
  col-costs)
  (define (calculate-cost row-start row-end col-start col-end)
    (define (row-cost)
      (let loop ([i (if (< row-start row-end) (+ row-start 1) (+ row-start -1))]
                 [cost 0])
        (cond
          [(equal? i row-end) cost]
          [(< row-start row-end) (loop (+ i 1) (+ cost (list-ref row-costs i)))]
          [else (loop (+ i -1) (+ cost (list-ref row-costs i)))])))
    (define (col-cost)
      (let loop ([i (if (< col-start col-end) (+ col-start 1) (+ col-start -1))]
                 [cost 0])
        (cond
          [(equal? i col-end) cost]
          [(< col-start col-end) (loop (+ i 1) (+ cost (list-ref col-costs i)))]
          [else (loop (+ i -1) (+ cost (list-ref col-costs i)))])))
    (+ (row-cost) (col-cost)))

  (calculate-cost (first start-pos) (first home-pos) (second start-pos) (second home-pos)))