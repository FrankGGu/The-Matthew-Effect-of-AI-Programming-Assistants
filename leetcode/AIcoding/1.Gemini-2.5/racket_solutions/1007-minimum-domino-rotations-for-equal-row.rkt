(define (min-domino-rotations A B)
  (let* ([n (length A)]
         (solve-for-target
           (lambda (x)
             (let loop ([i 0]
                        [rotations-for-A 0]
                        [rotations-for-B 0])
               (cond
                 [(= i n) (min rotations-for-A rotations-for-B)]
                 [else
                  (let ([a_i (list-ref A i)]
                        [b_i (list-ref B i)])
                    (cond
                      [(and (!= a_i x) (!= b_i x)) -1]
                      [else
                       (loop (+ i 1)
                             (if (!= a_i x) (+ rotations-for-A 1) rotations-for-A)
                             (if (!= b_i x) (+ rotations-for-B 1) rotations-for-B))]))])))]
    (let* ([val1 (list-ref A 0)]
           [val2 (list-ref B 0)]
           [res1 (solve-for-target val1)]
           [res2 (if (= val1 val2)
                     -1
                     (solve-for-target val2))])
      (cond
        [(and (= res1 -1) (= res2 -1)) -1]
        [(= res1 -1) res2]
        [(= res2 -1) res1]
        [else (min res1 res2)]))))