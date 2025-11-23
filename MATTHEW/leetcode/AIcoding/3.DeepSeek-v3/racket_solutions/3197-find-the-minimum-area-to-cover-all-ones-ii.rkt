#lang racket

(define (minimum-area-to-cover-ones grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define row-min rows)
  (define row-max -1)
  (define col-min cols)
  (define col-max -1)

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (= 1 (list-ref (list-ref grid i) j))
        (set! row-min (min row-min i))
        (set! row-max (max row-max i))
        (set! col-min (min col-min j))
        (set! col-max (max col-max j))))

  (if (or (= row-max -1) (= col-max -1))
      0
      (* (+ (- row-max row-min) 1) (+ (- col-max col-min) 1))))