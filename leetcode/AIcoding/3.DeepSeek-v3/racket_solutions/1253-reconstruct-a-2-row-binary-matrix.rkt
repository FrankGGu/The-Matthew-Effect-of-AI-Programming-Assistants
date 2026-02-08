(define/contract (reconstruct-matrix upper lower colsum)
  (-> exact-integer? exact-integer? (listof exact-integer?) (listof (listof exact-integer?)))
  (let* ([n (length colsum)]
         [matrix (make-list 2 (make-list n 0))]
         [upper-remaining upper]
         [lower-remaining lower]
         [possible #t])
    (for ([i (in-range n)]
          [sum (in-list colsum)])
      (cond
        [(= sum 2)
         (begin
           (list-set! (first matrix) i 1)
           (list-set! (second matrix) i 1)
           (set! upper-remaining (- upper-remaining 1))
           (set! lower-remaining (- lower-remaining 1)))]
        [(= sum 1)
         (if (>= upper-remaining lower-remaining)
             (begin
               (list-set! (first matrix) i 1)
               (set! upper-remaining (- upper-remaining 1)))
             (begin
               (list-set! (second matrix) i 1)
               (set! lower-remaining (- lower-remaining 1))))]
        [(= sum 0) void]))
      (when (or (< upper-remaining 0) (< lower-remaining 0))
        (set! possible #f)))
    (if (and possible (= upper-remaining 0) (= lower-remaining 0))
        matrix
        '())))