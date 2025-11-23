(define (construct-the-lexicographically-largest-valid-sequence n)
  (let* ([len (- (* 2 n) 1)]
         [result (make-vector len 0)] ; 0 indicates an empty slot
         [used (make-vector (+ n 1) #f)] ; used[x] is #t if x has been placed (once for 1, twice for x > 1)
         [found-solution #f]) ; Flag to stop search once the first (lexicographically largest) solution is found

    (define (backtrack index)
      (when (not found-solution) ; Only continue if a solution hasn't been found yet
        (cond
          [(= index len)
           (set! found-solution #t)] ; Solution found
          [(not (= (vector-ref result index) 0)) ; Slot already filled, move to next
           (backtrack (+ index 1))]
          [else ; Slot is empty, try placing numbers from n down to 1
           (for-each (lambda (x)
                       (when (not found-solution) ; Only try if a solution hasn't been found yet
                         (cond
                           [(= x 1)
                            (when (not (vector-ref used 1)) ; If 1 hasn't been placed
                              (vector-set! result index 1)
                              (vector-set! used 1 #t)
                              (backtrack (+ index 1))
                              (when (not found-solution) ; Backtrack only if no solution found
                                (vector-set! used 1 #f)
                                (vector-set! result index 0))))]
                           [else ; x > 1
                            (when (not (vector-ref used x)) ; If x hasn't been placed twice
                              (let ([pos2 (+ index x)]) ; Second position for x (j = i + x, based on example)
                                (when (and (< pos2 len)
                                           (= (vector-ref result pos2) 0))
                                  (vector-set! result index x)
                                  (vector-set! result pos2 x)
                                  (vector-set! used x #t)
                                  (backtrack (+ index 1))
                                  (when (not found-solution) ; Backtrack only if no solution found
                                    (vector-set! used x #f)
                                    (vector-set! result pos2 0)
                                    (vector-set! result index 0)))))]))))
                     (build-list n (lambda (i) (- n i)))) ; Generate list (n n-1 ... 1)
           ])))

    (backtrack 0)
    (vector->list result)))