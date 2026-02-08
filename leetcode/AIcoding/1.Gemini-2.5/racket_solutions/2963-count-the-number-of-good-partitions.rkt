(define (count-good-partitions nums)
  (define n (length nums))
  (define MOD 1000000007)

  ;; Modular exponentiation function (base^exp % MOD)
  (define (power base exp)
    (define (iter b e acc)
      (cond
        [(= e 0) acc]
        [(odd? e) (iter (modulo (* b b) MOD) (quotient e 2) (modulo (* acc b) MOD))]
        [else (iter (modulo (* b b) MOD) (quotient e 2) acc)]))
    (iter base exp 1))

  ;; Handle empty or single-element list case
  (when (= n 0)
    (error "Input list cannot be empty")) ; Problem constraints usually guarantee n >= 1
  (when (= n 1)
    (power 2 0)) ; Only one way to partition a single element: [[element]]

  ;; First pass: Build a hash table to store the last occurrence index of each number
  (define last-occurrence (make-hash))
  (for ([i (in-range n)]
        [val nums])
    (hash-set! last-occurrence val i))

  ;; Second pass: Count the number of good split points
  (define count-splits 0)
  (define current-max-reach 0) ; Tracks the maximum last_occurrence index encountered in the current segment

  (for ([i (in-range n)]
        [val nums])
    ;; Update current-max-reach with the maximum last_occurrence seen so far in the current potential segment
    (set! current-max-reach
          (max current-max-reach (hash-ref last-occurrence val)))

    ;; If the current index 'i' is equal to current-max-reach, it means all elements
    ;; from the start of the current segment up to 'i' have their last occurrences
    ;; within this range. This signifies a valid point to make a cut.
    ;; We only count splits that are not at the very end of the array.
    (when (and (= i current-max-reach) (< i (- n 1)))
      (set! count-splits (+ count-splits 1))))

  ;; The number of good partitions is 2 raised to the power of (number of good split points)
  (power 2 count-splits))