(define (four-sum nums target)
  (let* ([n (length nums)]
         [sorted-nums-list (sort nums <)]
         [sorted-nums (list->vector sorted-nums-list)]
         [result (list)])

    (when (>= n 4)
      (for ([i (in-range (- n 3))]) ; i from 0 to n-4
        (let ([val-i (vector-ref sorted-nums i)])
          ;; Pruning for i: If the smallest possible sum with current i is already greater than target,
          ;; then no further quadruplets can be formed with this i or any subsequent i.
          ;; (This optimization is for a `break` from the outer loop, but Racket's `for` doesn't have `break` directly.
          ;; We can simulate by returning early or using a conditional `for/first` if it's the outermost loop.
          ;; For nested loops, `unless` effectively acts as a `continue` for the current iteration.)
          (let ([min-sum-i (+ val-i
                              (vector-ref sorted-nums (+ i 1))
                              (vector-ref sorted-nums (+ i 2))
                              (vector-ref sorted-nums (+ i 3)))])
            (when (> min-sum-i target)
              (void)) ; Effectively 'continue' for this 'i', but if it's the first element, it implies no solution.
                      ; For `for` loops, just letting the current iteration finish and not doing anything further is the way.
                      ; However, if this condition means *all* subsequent `i`s will also be too large, we could exit early.
                      ; For now, let's keep it as a 'continue' for the current `i`.

              (let ([max-sum-i (+ val-i
                                  (vector-ref sorted-nums (- n 3))
                                  (vector-ref sorted-nums (- n 2))
                                  (vector-ref sorted-nums (- n 1)))])
                ;; Pruning for i: If the largest possible sum with current i is already less than target,
                ;; then no quadruplets can be formed with this i. Continue to the next i.
                (unless (< max-sum-i target)
                  ;; Skip duplicate for i
                  (when (or (= i 0) (not (= val-i (vector-ref sorted-nums (- i 1)))))
                    (for ([j (in-range (+ i 1) (- n 2))]) ; j from i+1 to n-3
                      (let ([val-j (vector-ref sorted-nums j)])
                        ;; Pruning for j: If the smallest possible sum with current i and j is already greater than target,
                        ;; then no further quadruplets can be formed with this i and j. Continue to the next j.
                        (let ([min-sum-j (+ val-i val-j
                                            (vector-ref sorted-nums (+ j 1))
                                            (vector-ref sorted-nums (+ j 2)))])
                          (when (> min-sum-j target)
                            (void)) ; Effectively 'continue' for this 'j'

                          (let ([max-sum-j (+ val-i val-j
                                              (vector-ref sorted-nums (- n 2))
                                              (vector-ref sorted-nums (- n 1)))])
                            ;; Pruning for j: If the largest possible sum with current i and j is already less than target,
                            ;; then no quadruplets can be formed with this i and j. Continue to the next j.
                            (unless (< max-sum-j target)
                              ;; Skip duplicate for j
                              (when (or (= j (+ i 1)) (not (= val-j (vector-ref sorted-nums (- j 1)))))

                                (let* ([left (+ j 1)]
                                       [right (- n 1)]
                                       [current-target (- target val-i val-j)])

                                  (let loop ([l left] [r right])
                                    (when (< l r)
                                      (let ([sum-lr (+ (vector-ref sorted-nums l) (vector-ref sorted-nums r))])
                                        (cond
                                          [(= sum-lr current-target)
                                           (set! result (cons (list val-i
                                                                     val-j
                                                                     (vector-ref sorted-nums l)
                                                                     (vector-ref sorted-nums r))
                                                               result))

                                           ;; Skip duplicates for l and r
                                           (let ([old-l-val (vector-ref sorted-nums l)])
                                             (let loop-l-skip ([new-l (+ l 1)])
                                               (if (and (< new-l r) (= (vector-ref sorted-nums new-l) old-l-val))
                                                   (loop-l-skip (+ new-l 1))
                                                   (let ([old-r-val (vector-ref sorted-nums r)])
                                                     (let loop-r-skip ([new-r (- r 1)])
                                                       (if (and (< new-l new-r) (= (vector-ref sorted-nums new-r) old-r-val))
                                                           (loop-r-skip (- new-r 1))
                                                           (loop new-l new-r)))))))

                                          [(< sum-lr current-target)
                                           ;; Move l and skip duplicates
                                           (let ([old-l-val (vector-ref sorted-nums l)])
                                             (let loop-l-skip ([new-l (+ l 1)])
                                               (if (and (< new-l r) (= (vector-ref sorted-nums new-l) old-l-val))
                                                   (loop-l-skip (+ new-l 1))
                                                   (loop new-l r))))]

                                          [(> sum-lr current-target)
                                           ;; Move r and skip duplicates
                                           (let ([old-r-val (vector-ref sorted-nums r)])
                                             (let loop-r-skip ([new-r (- r 1)])
                                               (if (and (< l new-r) (= (vector-ref sorted-nums new-r) old-r-val))
                                                   (loop-r-skip (- new-r 1))
                                                   (loop l new-r))))]))))))))))))))))
    (reverse result)))