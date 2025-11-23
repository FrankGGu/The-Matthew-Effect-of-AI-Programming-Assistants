#lang racket

(define (min-days grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))

  (define (count-islands)
    (define visited (make-vector rows #f))
    (define (dfs r c)
      (when (and (>= r 0) (< r rows) (>= c 0) (< c cols) (equal? (list-ref (list-ref grid r) c) 1) (not (vector-ref visited r)))
        (vector-set! visited r #t)
        (dfs (+ r 1) c)
        (dfs (- r 1) c)
        (dfs r (+ c 1))
        (dfs r (- c 1))))

    (define count 0)
    (for ([r (in-range rows)])
      (for ([c (in-range cols)])
        (when (and (equal? (list-ref (list-ref grid r) c) 1) (not (vector-ref visited r)))
          (set! count (+ count 1))
          (dfs r c))))
    count)

  (define (get-land-cell)
    (for/or ([r (in-range rows)]
             [c (in-range cols)]
             #:when (equal? (list-ref (list-ref grid r) c) 1))
      (cons r c)))

  (define (is-connected?)
    (= (count-islands) 1))

  (if (not (is-connected?))
      0
      (let ([cell (get-land-cell)])
        (when cell
          (define r (car cell))
          (define c (cdr cell))
          (define original (list-ref (list-ref grid r) c))
          (vector-set! (list-ref grid r) c 0)
          (define result (if (not (is-connected?)) 1 (if (and (>= r 1) (equal? (list-ref (list-ref grid (- r 1) ) c) 1)) 1 (if (and (< r (- rows 1)) (equal? (list-ref (list-ref grid (+ r 1)) c) 1)) 1 (if (and (>= c 1) (equal? (list-ref (list-ref grid r) (- c 1)) 1)) 1 (if (and (< c (- cols 1)) (equal? (list-ref (list-ref grid r) (+ c 1)) 1)) 1 2)))))
          (vector-set! (list-ref grid r) c original)
          result))))