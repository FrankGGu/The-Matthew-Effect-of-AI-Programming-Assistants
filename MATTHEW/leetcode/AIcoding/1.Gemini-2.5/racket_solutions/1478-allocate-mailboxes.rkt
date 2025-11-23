(define (min-distance-sum houses k)
  (let* ([n (length houses)]
         [sorted-houses (list->vector (sort houses <))] ; Convert list to sorted vector
         ; cost[i][j] stores the minimum cost to place one mailbox for houses[i]...houses[j]
         [cost (make-vector n (lambda () (make-vector n +inf.0)))]
         ; dp[k_val][i_val] stores the minimum cost to place k_val mailboxes for houses[0]...houses[i_val-1]
         [dp (make-vector (+ k 1) (lambda () (make-vector (+ n 1) +inf.0)))])

    ; Helper function to calculate the cost for a single mailbox covering a segment of houses
    (define (calculate-segment-cost i j)
      (let* ([median-idx (quotient (+ i j) 2)]
             [median-val (vector-ref sorted-houses median-idx)])
        (for/sum ([p (range i (+ j 1))])
          (abs (- (vector-ref sorted-houses p) median-val)))))

    ; Precompute costs for all possible segments [i, j]
    (for ([i (range n)])
      (for ([j (range i (+ n 1))]) ; j goes from i to n-1
        (vector-set! (vector-ref cost i) j (calculate-segment-cost i j))))

    ; Initialize dp[0][0] = 0 (0 mailboxes for 0 houses, cost is 0)
    (vector-set! (vector-ref dp 0) 0 0)

    ; Fill the DP table
    (for ([num-mailboxes (range 1 (+ k 1))]) ; Iterate for k_val from 1 to K
      (for ([num-houses (range 1 (+ n 1))]) ; Iterate for i_val from 1 to N (covering houses[0]...houses[i_val-1])
        ; Iterate over all possible split points 'j'
        ; 'j' represents the number of houses covered by (num-mailboxes - 1) mailboxes.
        ; So, (num-mailboxes - 1) mailboxes cover houses[0]...houses[j-1].
        ; The last mailbox covers houses[j]...houses[num-houses-1].
        (for ([j (range num-houses)]) ; j from 0 to num-houses - 1
          (let* ([prev-k-cost (vector-ref (vector-ref dp (- num-mailboxes 1)) j)]
                 [current-segment-cost (vector-ref (vector-ref cost j) (- num-houses 1))]
                 [total-cost (+ prev-k-cost current-segment-cost)])
            (when (< total-cost (vector-ref (vector-ref dp num-mailboxes) num-houses))
              (vector-set! (vector-ref dp num-mailboxes) num-houses total-cost))))))

    ; The final result is dp[k][n]
    (vector-ref (vector-ref dp k) n)))