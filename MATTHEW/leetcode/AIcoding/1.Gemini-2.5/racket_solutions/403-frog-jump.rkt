(define (can-cross stones)
  (define n (length stones))
  (define last-stone (last stones))

  ;; dp is a hash table where keys are stone positions
  ;; and values are sets of possible jump sizes to reach that stone.
  (define dp (make-hash))

  ;; Initialize dp[0]. A '0' jump size signifies we are at stone 0.
  ;; This allows the first jump of 1 unit to be correctly processed.
  (hash-set! dp 0 (set 0))

  ;; Create a set for efficient lookup of stone positions.
  (define stone-positions (list->set stones))

  ;; Iterate through each stone in ascending order.
  (for ([current-stone (in-list stones)])
    ;; Retrieve the set of jump sizes that can lead to the current-stone.
    ;; If current-stone is not in dp, it means it's unreachable, so we get an empty set.
    (define possible-prev-jumps (hash-ref dp current-stone (set)))

    ;; For each jump size 'k' that allowed reaching 'current-stone':
    (for ([prev-jump-size (in-set possible-prev-jumps)])
      ;; The next jump can be k-1, k, or k+1 units.
      (for ([next-jump-size (in-list (list (- prev-jump-size 1)
                                            prev-jump-size
                                            (+ prev-jump-size 1)))])
        ;; A jump must always be positive.
        (when (> next-jump-size 0)
          (define next-stone-pos (+ current-stone next-jump-size))

          ;; If the next position is a valid stone:
          (when (set-member? next-stone-pos stone-positions)
            ;; Add 'next-jump-size' to the set of jumps for 'next-stone-pos'.
            ;; If 'next-stone-pos' is not yet in dp, hash-ref returns an empty set,
            ;; and set-add creates a new set with 'next-jump-size'.
            (hash-set! dp next-stone-pos
                       (set-add (hash-ref dp next-stone-pos (set))
                                next-jump-size)))))))

  ;; After processing all stones, check if the last stone is reachable.
  ;; It is reachable if its corresponding set of jump sizes in 'dp' is not empty.
  (not (set-empty? (hash-ref dp last-stone (set)))))