#lang racket

(require math/matrix)

(define (max-rook-sum grid)
  (define rows (matrix-num-rows grid))
  (define cols (matrix-num-cols grid))
  (define (get i j) (matrix-ref grid i j))

  (define (max-three lst)
    (define sorted (sort lst >))
    (if (< (length sorted) 3)
        0
        (+ (first sorted) (second sorted) (third sorted))))

  (define (process-row i)
    (define row (matrix->list (matrix-row grid i)))
    (define top3 (max-three row))
    (define (process-col j)
      (define col (matrix->list (matrix-col grid j)))
      (define col-top3 (max-three col))
      (define val (get i j))
      (define row-sum (- top3 val))
      (define col-sum (- col-top3 val))
      (+ row-sum col-sum val))

    (for/fold ([max-sum -inf.0]) ([j (in-range cols)])
      (max max-sum (process-col j))))

  (for/fold ([result -inf.0]) ([i (in-range rows)])
    (max result (process-row i))))