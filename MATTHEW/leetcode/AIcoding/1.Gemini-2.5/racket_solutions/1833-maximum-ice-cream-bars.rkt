(require racket/list)

(define (max-ice-cream costs coins)
  (let* ([sorted-costs (sort costs <)])
    (let loop ([current-coins coins]
               [current-costs sorted-costs]
               [bars-bought 0])
      (cond
        [(empty? current-costs) bars-bought]
        [(< current-coins (car current-costs)) bars-bought]
        [else (loop (- current-coins (car current-costs))
                    (cdr current-costs)
                    (add1 bars-bought))]))))