#lang racket

(define (minimize-the-difference mat target)
  (let* ([num-rows (length mat)]
         [max-val-per-cell 70] ; Given constraint: 1 <= mat[i][j] <= 70
         [max-possible-sum (* num-rows max-val-per-cell)] ; Maximum possible sum
         ; dp is a boolean vector where dp[s] is #t if sum s is achievable
         [dp (make-vector (+ max-possible-sum 1) #f)])

    ; Initialize: sum 0 is achievable before processing any rows
    (vector-set! dp 0 #t)

    ; Iterate through each row of the matrix
    (for-each
     (lambda (row)
       ; Create a new dp vector for the sums achievable after processing the current row
       (let ([next-dp (make-vector (+ max-possible-sum 1) #f)])
         ; Iterate through all possible sums 's' from the previous step
         (for ([s (in-range (+ max-possible-sum 1))])
           (when (vector-ref dp s) ; If sum 's' was achievable
             ; For each number 'x' in the current row
             (for-each
              (lambda (x)
                (let ([new-sum (+ s x)])
                  ; If the new sum is within the bounds, mark it as achievable
                  (when (<= new-sum max-possible-sum)
                    (vector-set! next-dp new-sum #t))))
              row)))
         ; Update dp to the new set of achievable sums
         (set! dp next-dp)))
     mat)

    ; After processing all rows, find the minimum difference
    (let ([min-diff +inf.0]) ; Initialize with positive infinity
      (for ([s (in-range (+ max-possible-sum 1))])
        (when (vector-ref dp s) ; If sum 's' is achievable
          (set! min-diff (min min-diff (abs (- s target))))))
      min-diff)))