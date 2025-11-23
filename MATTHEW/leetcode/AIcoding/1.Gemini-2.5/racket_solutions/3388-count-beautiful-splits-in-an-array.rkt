#lang racket

(define (count-beautiful-splits nums)
  (define N (vector-length nums))
  (define MOD 1000000007)

  (define dp-prev (make-vector (add1 N) 0))
  (vector-set! dp-prev 0 1) ; Base case: 0 elements, 0 splits, 1 way.

  (define total-beautiful-splits 0)

  (for ([j (in-range 1 (add1 N))]) ; j is the number of subarrays, and also the divisor for sums
    (define dp-curr (make-vector (add1 N) 0))
    (define map-for-prev-j-values (make-hash)) ; Stores (list start_val start_prefix_rem) -> sum_of_dp_prev_values

    ; Compute prefix sums modulo j for the current divisor j
    (define prefix-sum-mod-j (make-vector (add1 N) 0))
    (for ([idx (in-range N)])
      (vector-set! prefix-sum-mod-j (add1 idx)
                   (remainder (+ (vector-ref prefix-sum-mod-j idx)
                                 (vector-ref nums idx))
                              j)))

    ; Initialize map-for-prev-j-values with dp-prev[0] for the conceptual starting position p=0
    ; dp-prev[0] represents 1 way to have 0 elements split into j-1 (which is 0) subarrays.
    ; If a new subarray starts at index 0, its first element is nums[0] and prefix sum before it is prefix-sum-mod-j[0].
    (when (> (vector-ref dp-prev 0) 0)
      (define start-val (vector-ref nums 0))
      (define start-prefix-rem (vector-ref prefix-sum-mod-j 0))
      (define key-for-map (list start-val start-prefix-rem))
      (hash-set! map-for-prev-j-values key-for-map
                 (remainder (+ (hash-ref map-for-prev-j-values key-for-map 0)
                               (vector-ref dp-prev 0))
                            MOD)))

    (for ([i (in-range 1 (add1 N))]) ; i is current end index + 1 (so nums[0...i-1] is the prefix being considered)
      ; Calculate dp-curr[i]
      ; A split ending at index i-1 needs nums[i-1] as its end value.
      ; Its total sum modulo j should be 0, meaning prefix-sum-mod-j[i] must equal prefix-sum-mod-j[p] (where p is the start index of this last subarray).
      (define target-end-val (vector-ref nums (sub1 i)))
      (define target-end-prefix-rem (vector-ref prefix-sum-mod-j i))
      (define key-to-query (list target-end-val target-end-prefix-rem))
      (vector-set! dp-curr i (hash-ref map-for-prev-j-values key-to-query 0))

      ; After dp-curr[i] is calculated, update the map with dp-prev[i] for the next iteration of i
      ; (i.e., when i becomes the starting position 'p' for a future subarray).
      ; dp-prev[i] is count of ways to split nums[0...i-1] into j-1 subarrays.
      ; If a new subarray starts at index i, its first element is nums[i].
      ; Its prefix sum before it is prefix-sum-mod-j[i].
      (when (< i N) ; Only if nums[i] exists
        (when (> (vector-ref dp-prev i) 0)
          (define start-val (vector-ref nums i))
          (define start-prefix-rem (vector-ref prefix-sum-mod-j i))
          (define key-for-map (list start-val start-prefix-rem))
          (hash-set! map-for-prev-j-values key-for-map
                     (remainder (+ (hash-ref map-for-prev-j-values key-for-map 0)
                                   (vector-ref dp-prev i)))
                                MOD))))

    (set! dp-prev dp-curr) ; Update dp-prev for the next 'j' iteration
    (set! total-beautiful-splits (remainder (+ total-beautiful-splits (vector-ref dp-prev N)) MOD)))

  total-beautiful-splits)