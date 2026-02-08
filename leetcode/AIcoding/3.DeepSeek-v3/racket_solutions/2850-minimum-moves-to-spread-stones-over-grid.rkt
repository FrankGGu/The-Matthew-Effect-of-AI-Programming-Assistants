#lang racket

(define (minimum-moves grid)
  (define stones '())
  (define holes '())
  (define rows (vector-length grid))
  (define cols (if (zero? rows) 0 (vector-length (vector-ref grid 0))))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define val (vector-ref (vector-ref grid i) j))
      (cond
        [(> val 1) (set! stones (cons (list i j (- val 1)) stones))]
        [(zero? val) (set! holes (cons (list i j) holes))])))

  (define (manhattan a b)
    (+ (abs (- (first a) (first b))) (abs (- (second a) (second b)))))

  (define (permute lst)
    (if (null? lst) '(())
        (apply append
               (map (lambda (x)
                      (map (lambda (y) (cons x y))
                           (permute (remove x lst))))
                    lst))))

  (define min-moves +inf.0)
  (define stone-count (length stones))
  (define hole-count (length holes))

  (when (= stone-count hole-count)
    (for ([perm (permute stones)])
      (define total 0)
      (for ([s perm] [h holes])
        (set! total (+ total (* (third s) (manhattan (take s 2) h)))))
        (when (>= total min-moves) (break)))
      (when (< total min-moves)
        (set! min-moves total))))

  (if (= min-moves +inf.0) 0 (exact-round min-moves)))