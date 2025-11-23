(define (find-subsequences nums)
  (define result-set (set))
  (define n (vector-length nums))

  (define (backtrack start-index current-subsequence-reversed)
    (when (>= (length current-subsequence-reversed) 2)
      (set! result-set (set-add result-set (reverse current-subsequence-reversed))))

    (define seen-in-level (set))

    (for ([i (in-range start-index n)])
      (define num-i (vector-ref nums i))

      (unless (set-member? seen-in-level num-i)
        (when (or (empty? current-subsequence-reversed)
                  (>= num-i (car current-subsequence-reversed)))
          (set! seen-in-level (set-add seen-in-level num-i))
          (backtrack (+ i 1) (cons num-i current-subsequence-reversed))))))

  (backtrack 0 '())
  (set->list result-set))