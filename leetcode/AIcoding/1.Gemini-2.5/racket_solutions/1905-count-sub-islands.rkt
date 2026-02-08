#lang racket

(define (count-sub-islands grid1 grid2)
  (define m (length grid1))
  (define n (length (car grid1)))

  (define mutable-grid2 (make-vector m))
  (for ([i (range m)])
    (vector-set! mutable-grid2 i (list->vector (list-ref grid2 i))))

  (define (is-valid r c)
    (and (>= r 0) (< r m)
         (>= c 0) (< c n)))

  (define (dfs r c)
    (if (not (is-valid r c))
        #t
        (let ([cell-val (vector-ref (vector-ref mutable-grid2 r) c)])
          (if (= cell-val 0)
              #t
              (begin
                (vector-set! (vector-ref mutable-grid2 r) c 0)

                (define current-cell-is-in-grid1 (= (list-ref (list-ref grid1 r) c) 1))

                (define neighbor-results
                  (and (dfs (add1 r) c)
                       (dfs (sub1 r) c)
                       (dfs r (add1 c))
                       (dfs r (sub1 c))))

                (and current-cell-is-in-grid1 neighbor-results))))))

  (define sub-island-count 0)
  (for ([r (range m)])
    (for ([c (range n)])
      (when (= (vector-ref (vector-ref mutable-grid2 r) c) 1)
        (when (dfs r c)
          (set! sub-island-count (add1 sub-island-count))))))

  sub-island-count)