(define (stone-game-vi aliceValues bobValues)
  (let* ([n (length aliceValues)]
         ; Combine aliceValues and bobValues into a list of pairs (alice_val bob_val)
         [stones (map list aliceValues bobValues)]
         ; Sort stones in descending order based on the sum of their values (a_i + b_i)
         [sorted-stones (sort stones (lambda (s1 s2)
                                       (> (+ (car s1) (cadr s1))
                                          (+ (car s2) (cadr s2)))))]
         [alice-score 0]
         [bob-score 0])
    ; Iterate through the sorted stones, alternating turns
    (for ([stone sorted-stones]
          [idx (in-naturals)]) ; idx represents the turn number (0-indexed)
      (if (even? idx) ; Alice's turn (0, 2, 4, ...)
          (set! alice-score (+ alice-score (car stone)))
          ; Bob's turn (1, 3, 5, ...)
          (set! bob-score (+ bob-score (cadr stone)))))
    ; Return Alice's total score minus Bob's total score
    (- alice-score bob-score)))