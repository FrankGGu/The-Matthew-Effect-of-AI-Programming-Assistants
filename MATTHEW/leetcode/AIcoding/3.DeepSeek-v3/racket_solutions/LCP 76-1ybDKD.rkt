#lang racket

(define (magical-board board)
  (define rows (length board))
  (define cols (if (null? board) 0 (length (car board))))

  (define (get-cell r c)
    (list-ref (list-ref board r) c))

  (define (set-cell! r c val)
    (set-car! (list-tail (list-ref board r) c) val))

  (define (flip-row r)
    (for ([c (in-range cols)])
      (set-cell! r c (- 1 (get-cell r c)))))

  (define (flip-col c)
    (for ([r (in-range rows)])
      (set-cell! r c (- 1 (get-cell r c))))

  (define (row-all-zeros? r)
    (for/and ([c (in-range cols)])
      (zero? (get-cell r c))))

  (define (col-all-zeros? c)
    (for/and ([r (in-range rows)])
      (zero? (get-cell r c)))

  (define (solve)
    (for ([r (in-range rows)])
      (when (zero? (get-cell r 0))
        (flip-row r)))
    (for ([c (in-range 1 cols)])
      (when (zero? (get-cell 0 c))
        (flip-col c)))
    (for/and ([r (in-range 1 rows)])
      (for/and ([c (in-range 1 cols)])
        (= (get-cell r c) (get-cell 0 c)))))

  (if (solve) board #f))