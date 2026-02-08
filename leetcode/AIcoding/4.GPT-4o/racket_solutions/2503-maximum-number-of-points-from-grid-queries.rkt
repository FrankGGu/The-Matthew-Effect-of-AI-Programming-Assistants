#lang racket

(define (maxPoints grid queries)
  (define (height) (vector (length grid)) (define (width) (vector (length (vector-ref grid 0)))))
  (define (build-sum-table)
    (define sum-table (make-vector (+ (height) 1) (make-vector (+ (width) 1) 0)))
    (for* ([i (in-range (height))] [j (in-range (width))])
      (vector-set! sum-table (+ i 1) (+ (vector-ref sum-table (+ i 1)) (vector-ref (vector-ref grid i) j)))
      (for ([k (in-range (+ (height) 1))])
        (vector-set! sum-table k (+ (vector-ref sum-table k) (vector-ref (vector-ref grid i) j)))))
    sum-table)

  (define sum-table (build-sum-table))
  (define results '())

  (for ([q queries])
    (define x (car q))
    (define y (cadr q))
    (define current-sum (vector-ref (vector-ref sum-table (+ x 1)) (+ y 1)))
    (vector-set! results (length results) current-sum))

  results)

(maxPoints (vector (vector 1 2 3) (vector 4 5 6) (vector 7 8 9)) (list (list 1 1) (list 2 2) (list 0 0)))