(define (equalSumGridPartition grid)
  (define n (length grid))
  (define (row-sum row) (apply + row))
  (define (col-sum col) (apply + (map (lambda (r) (list-ref r col)) grid)))

  (define (can-partition? row-start row-end col-start col-end)
    (define total-sum (let loop ([r row-start] [sum 0])
                         (if (> r row-end)
                             sum
                             (loop (add1 r) (+ sum (apply + (list-ref (list-ref grid r) (in-range col-start col-end))))))))

    (define (find-horizontal-split)
      (let loop ([r row-start] [current-sum 0])
        (cond
          [(> r row-end) #f]
          [(equal? current-sum (- total-sum current-sum)) #t]
          [else (loop (add1 r) (+ current-sum (apply + (list-ref (list-ref grid r) (in-range col-start col-end)))))])))

    (define (find-vertical-split)
      (let loop ([c col-start] [current-sum 0])
        (cond
          [(> c col-end) #f]
          [(equal? current-sum (- total-sum current-sum)) #t]
          [else (loop (add1 c) (+ current-sum (apply + (map (lambda (r) (list-ref r c)) (in-range (in-range row-start row-end) grid)))))])))

    (or (find-horizontal-split) (find-vertical-split)))

  (can-partition? 0 (- n 1) 0 (- n 1)))