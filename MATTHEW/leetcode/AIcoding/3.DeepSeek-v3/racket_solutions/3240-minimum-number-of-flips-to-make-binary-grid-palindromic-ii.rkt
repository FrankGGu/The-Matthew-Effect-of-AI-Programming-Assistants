#lang racket

(define (min-flips grid)
  (let* ([n (length grid)]
         [m (length (first grid))]
         [total 0])
    (for ([i (in-range (quotient n 2))])
      (for ([j (in-range m)])
        (let* ([i1 (- n 1 i)]
               [j1 (- m 1 j)]
               [count (+ (if (equal? (list-ref (list-ref grid i) j) (list-ref (list-ref grid i1) j1)) 0 1)
                           (if (equal? (list-ref (list-ref grid i) j1) (list-ref (list-ref grid i1) j)) 0 1))])
               [flips (min count (- 4 count))])
          (set! total (+ total flips)))))
    total))