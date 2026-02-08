#lang racket

(define spreadsheet%
  (class object%
    (super-new)

    (init-field rows cols)
    (define grid (make-vector rows (make-vector cols "")))

    (define/public (set-cell row col val)
      (vector-set! (vector-ref grid row) col val))

    (define/public (get-cell row col)
      (let ([val (vector-ref (vector-ref grid row) col)])
        (if (string? val)
            (if (string-prefix? val "=")
                (evaluate (substring val 1) grid)
                val)
            val)))

    (define/public (get-all-cells)
      (for/vector ([row (in-range rows)])
        (for/vector ([col (in-range cols)])
          (get-cell row col))))
)

(define (evaluate expr grid)
  (define (parse-cell-ref s)
    (let ([col (string-ref s 0)]
          [row (string->number (substring s 1))])
      (cons (- (char->integer col) 65) row))

  (define (eval-expr e)
    (cond
      [(string-prefix? e "SUM(")
       (let* ([end (substring e 4 (sub1 (string-length e)))]
              [cells (string-split end ",")]
              [sum 0])
         (for ([cell cells])
           (let ([pos (parse-cell-ref cell)])
             (set! sum (+ sum (get-cell (car pos) (cdr pos)))))
         sum)]
      [(string-prefix? e "AVG(")
       (let* ([end (substring e 4 (sub1 (string-length e)))]
              [cells (string-split end ",")]
              [sum 0]
              [count (length cells)])
         (for ([cell cells])
           (let ([pos (parse-cell-ref cell)])
             (set! sum (+ sum (get-cell (car pos) (cdr pos)))))
         (/ sum count))]
      [else
       (let ([pos (parse-cell-ref e)])
         (get-cell (car pos) (cdr pos)))]))

  (eval-expr expr))