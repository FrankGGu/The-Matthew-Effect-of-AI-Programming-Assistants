(define (solve-linear slices num-to-pick)
  (let* ([n (length slices)]
         [k num-to-pick]
         [neg-inf (- (expt 10 18))] ; A large negative number to represent -infinity
         ; dp[i][j] represents the maximum sum picking j slices from the first i slices
         ; Size (n+1) x (k+1)
         [dp (make-vector (+ n 1) (lambda () (make-vector (+ k 1) neg-inf)))])

    ; Base case: dp[i][0] = 0 for all i (picking 0 slices always results in sum 0)
    (for ([i (in-range (+ n 1))])
      (vector-set! (vector-ref dp i) 0 0))

    ; Fill the DP table
    (for* ([i (in-range 1 (+ n 1))] ; Iterate through slices (1-indexed for DP table)
           [j (in-range 1 (+ k 1))]) ; Iterate through number of slices to pick
      (let ([current-slice-val (list-ref slices (- i 1))]) ; Value of the current slice (0-indexed)

        ; Case 1: Don't pick the current slice (slices[i-1])
        ; The max sum is the same as picking j slices from the first i-1 slices
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j))

        ; Case 2: Pick the current slice (slices[i-1])
        (let ([pick-candidate neg-inf]) ; Initialize candidate sum for picking current slice
          (cond
            ; If i >= 2, we pick slices[i-1] and j-1 slices from slices[0...i-3]
            ; (i.e., from the first i-2 slices, as slices[i-2] cannot be picked)
            [(>= i 2)
             (let ([prev-dp-val (vector-ref (vector-ref dp (- i 2)) (- j 1))])
               ; Only consider if the previous state was reachable
               (when (!= prev-dp-val neg-inf)
                 (set! pick-candidate (+ current-slice-val prev-dp-val))))]
            ; If i == 1, we can only pick slices[0] if j == 1
            [(and (= i 1) (= j 1))
             (set! pick-candidate current-slice-val)])

          ; Update dp[i][j] with the maximum of not picking and picking the current slice
          ; Only update if picking the current slice leads to a reachable state
          (when (!= pick-candidate neg-inf)
            (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp i) j) pick-candidate)))))))

    ; The result is the max sum picking k slices from all n slices
    (vector-ref (vector-ref dp n) k)))

(define (pizza-with-3n-slices slices)
  (let* ([total-slices (length slices)]
         [num-to-pick (/ total-slices 3)])

    ; Handle the circular arrangement by solving two linear problems:
    ; 1. Exclude the last slice: consider slices[0...total-slices-2]
    ; 2. Exclude the first slice: consider slices[1...total-slices-1]
    ; The maximum of these two cases is the answer.
    (if (= total-slices 0)
        0 ; No slices, no value
        (max (solve-linear (take slices (- total-slices 1)) num-to-pick)
             (solve-linear (drop slices 1) num-to-pick)))))