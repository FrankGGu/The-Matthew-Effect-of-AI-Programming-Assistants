(define (minimum-coins prices)
  (let* ([n (vector-length prices)]
         [memo (make-vector (+ n 3) -1)]) ; Use -1 as an uncomputed marker

    ; Initialize base cases for dp[n], dp[n+1], dp[n+2] to 0.
    ; These represent the cost of buying fruits from these indices onwards,
    ; which is 0 because there are no fruits left to buy.
    (vector-set! memo n 0)
    (vector-set! memo (+ n 1) 0)
    (vector-set! memo (+ n 2) 0)

    ; dp function for memoized recursion
    ; dp(i) calculates the minimum cost to acquire all fruits from index i to n-1.
    (define (dp i)
      ; Retrieve cached value if already computed
      (let ([cached-val (vector-ref memo i)])
        (if (not (= cached-val -1))
            cached-val
            ; If not computed, calculate the cost
            (let ([cost (+ (vector-ref prices i) ; Cost of buying fruit i
                           (dp (+ i 3)))])      ; Plus the minimum cost to acquire fruits from i+3 onwards
                                                ; (since i+1 and i+2 are free)
              ; Store the computed cost and return it
              (vector-set! memo i cost)
              cost))))

    ; Start the dynamic programming process from index 0
    (dp 0)))