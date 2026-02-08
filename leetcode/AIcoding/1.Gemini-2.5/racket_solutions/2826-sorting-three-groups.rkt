(define (sorting-three-groups nums)
  (define N (length nums))
  (define nums-vec (list->vector nums))
  (define max-val 1000)
  (define max-cost (+ N 1)) ; A value larger than any possible cost

  ; dp is a vector of 4 vectors.
  ; dp[g] is a vector of size (max-val + 1).
  ; dp[g][v] stores the minimum cost for the prefix nums[0...i-1]
  ; such that nums[i-1] (the current element being processed) is changed to v
  ; and belongs to group g.
  ; dp[0] is a virtual group with 0 cost, representing the state before group 1 starts.
  (define dp (make-vector 4))

  ; Initialize dp[0] to all zeros (base case for starting group 1)
  (vector-set! dp 0 (make-vector (+ max-val 1) 0))
  ; Initialize dp[1], dp[2], dp[3] to max-cost (representing infinity)
  (for ([g (in-range 1 4)])
    (vector-set! dp g (make-vector (+ max-val 1) max-cost)))

  (for ([i (in-range N)]) ; Iterate through each element in nums
    (define current-num (vector-ref nums-vec i))

    ; new-dp-g1, new-dp-g2, new-dp-g3 store results for the current element nums[i]
    (define new-dp-g1 (make-vector (+ max-val 1) max-cost))
    (define new-dp-g2 (make-vector (+ max-val 1) max-cost))
    (define new-dp-g3 (make-vector (+ max-val 1) max-cost))

    ; These variables will store the prefix minimums of dp values for previous groups.
    ; e.g., min-cost-prev-g0-prefix will store min(dp[0][u]) for u <= v.
    (define min-cost-prev-g0-prefix max-cost)
    (define min-cost-prev-g1-prefix max-cost)
    (define min-cost-prev-g2-prefix max-cost)
    (define min-cost-prev-g3-prefix max-cost) ; Used for continuing group 3

    (for ([v (in-range 1 (+ max-val 1))]) ; Iterate through all possible target values v (1 to 1000)
      (define cost-change (if (= current-num v) 0 1)) ; Cost to change current-num to v

      ; Update prefix minimums from the previous element's DP values (dp array)
      ; These represent the minimum cost to end a group g with a value u <= v at the previous index.
      (set! min-cost-prev-g0-prefix (min min-cost-prev-g0-prefix (vector-ref (vector-ref dp 0) v)))
      (set! min-cost-prev-g1-prefix (min min-cost-prev-g1-prefix (vector-ref (vector-ref dp 1) v)))
      (set! min-cost-prev-g2-prefix (min min-cost-prev-g2-prefix (vector-ref (vector-ref dp 2) v)))
      (set! min-cost-prev-g3-prefix (min min-cost-prev-g3-prefix (vector-ref (vector-ref dp 3) v)))

      ; Calculate new_dp_g1[v]:
      ; The current element `nums[i]` is in group 1 and changed to `v`.
      ; It can either:
      ; 1. Start group 1 (previous element was effectively in virtual group 0, with value <= v).
      ;    Cost is `min-cost-prev-g0-prefix`.
      ; 2. Continue group 1 (previous element was in group 1, with value <= v).
      ;    Cost is `min-cost-prev-g1-prefix`.
      (vector-set! new-dp-g1 v (+ cost-change (min min-cost-prev-g0-prefix min-cost-prev-g1-prefix)))

      ; Calculate new_dp_g2[v]:
      ; The current element `nums[i]` is in group 2 and changed to `v`.
      ; It can either:
      ; 1. Start group 2 (previous element was in group 1, with value <= v).
      ;    Cost is `min-cost-prev-g1-prefix`.
      ; 2. Continue group 2 (previous element was in group 2, with value <= v).
      ;    Cost is `min-cost-prev-g2-prefix`.
      (vector-set! new-dp-g2 v (+ cost-change (min min-cost-prev-g1-prefix min-cost-prev-g2-prefix)))

      ; Calculate new_dp_g3[v]:
      ; The current element `nums[i]` is in group 3 and changed to `v`.
      ; It can either:
      ; 1. Start group 3 (previous element was in group 2, with value <= v).
      ;    Cost is `min-cost-prev-g2-prefix`.
      ; 2. Continue group 3 (previous element was in group 3, with value <= v).
      ;    Cost is `min-cost-prev-g3-prefix`.
      (vector-set! new-dp-g3 v (+ cost-change (min min-cost-prev-g2-prefix min-cost-prev-g3-prefix)))
      )

    ; Update dp for the next iteration (dp now holds results for nums[0...i])
    (vector-set! dp 1 new-dp-g1)
    (vector-set! dp 2 new-dp-g2)
    (vector-set! dp 3 new-dp-g3))

  ; After iterating through all elements, the final answer is the minimum cost
  ; among all possible ending values in group 3.
  (define final-min-cost max-cost)
  (for ([v (in-range 1 (+ max-val 1))])
    (set! final-min-cost (min final-min-cost (vector-ref (vector-ref dp 3) v))))

  final-min-cost)