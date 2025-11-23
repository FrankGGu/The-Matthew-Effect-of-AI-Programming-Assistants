(define (equal-sum-grid-partition-ii grid)
  (define m (vector-length grid))
  (when (zero? m) #f)
  (define n (vector-length (vector-ref grid 0)))
  (when (zero? n) #f)

  ;; A grid must have at least 2 rows and 2 columns to be partitioned into 4 sub-grids
  ;; by one horizontal and one vertical cut.
  (when (or (< m 2) (< n 2)) #f)

  ;; Calculate 2D prefix sums.
  ;; P[i][j] stores the sum of elements in the sub-grid from (0,0) to (i-1, j-1).
  ;; The prefix sum array will have dimensions (m+1) x (n+1).
  (define P (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

  (for* ([i (in-range 1 (+ m 1))]
         [j (in-range 1 (+ n 1))])
    (vector-set! (vector-ref P i) j
                 (+ (vector-ref (vector-ref grid (- i 1)) (- j 1)) ; Current element
                    (vector-ref (vector-ref P (- i 1)) j)           ; Sum above
                    (vector-ref (vector-ref P i) (- j 1))           ; Sum to the left
                    (- (vector-ref (vector-ref P (- i 1)) (- j 1)))))) ; Overlap

  ;; Helper function to get the sum of a sub-grid from (r1, c1) to (r2-1, c2-1)
  (define (get-sum r1 c1 r2 c2)
    (- (+ (vector-ref (vector-ref P r2) c2)
          (vector-ref (vector-ref P r1) c1))
       (vector-ref (vector-ref P r1) c2)
       (vector-ref (vector-ref P r2) c1)))

  (define total-sum (get-sum 0 0 m n))

  ;; If the total sum is not divisible by 4, it's impossible to partition into 4 equal sums.
  (when (not (zero? (remainder total-sum 4)))
    #f)

  (define target-sum (/ total-sum 4))

  ;; Iterate through all possible horizontal and vertical cut positions.
  ;; A horizontal cut at row 'r' means rows 0 to r-1 are above, and r to m-1 are below.
  ;; 'r' can range from 1 to m-1 (exclusive of 0 and m).
  ;; A vertical cut at column 'c' means columns 0 to c-1 are left, and c to n-1 are right.
  ;; 'c' can range from 1 to n-1 (exclusive of 0 and n).
  (for/first ([r (in-range 1 m)]
              [c (in-range 1 n)]
              #:when (let ([sum1 (get-sum 0 0 r c)]    ; Top-Left
                           [sum2 (get-sum 0 c r n)]    ; Top-Right
                           [sum3 (get-sum r 0 m c)]    ; Bottom-Left
                           [sum4 (get-sum r c m n)])   ; Bottom-Right
                       (and (= sum1 target-sum)
                            (= sum2 target-sum)
                            (= sum3 target-sum)
                            (= sum4 target-sum))))
    #t ; If such a partition is found, return #t
    #:else #f)) ; If no such partition is found after checking all possibilities, return #f