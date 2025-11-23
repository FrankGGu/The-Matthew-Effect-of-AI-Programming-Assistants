#lang racket

(define (removeStones stones)
  (define (find-parent parents x)
    (if (not (= (vector-ref parents x) x))
        (find-parent parents (vector-ref parents x))
        x))

  (define (union parents x y)
    (define rootX (find-parent parents x))
    (define rootY (find-parent parents y))
    (when (not (= rootX rootY))
      (vector-set! parents rootX rootY)))

  (define n (length stones))
  (define parents (make-vector n))

  (for ([i (in-range n)])
    (vector-set! parents i i))

  (for ([i (in-range n)]
        [j (in-range i n)])
    (when (or (= (vector-ref stones i) (vector-ref stones j))
              (= (vector-ref stones i 1) (vector-ref stones j 1)))
      (union parents i j)))

  (define roots (for*/list ([i (in-range n)])
                  (find-parent parents i)))

  (define unique-roots (define-set (set roots)))
  (- n (length unique-roots)))

(removeStones '((0 0) (0 1) (1 0) (1 1) (2 2)))