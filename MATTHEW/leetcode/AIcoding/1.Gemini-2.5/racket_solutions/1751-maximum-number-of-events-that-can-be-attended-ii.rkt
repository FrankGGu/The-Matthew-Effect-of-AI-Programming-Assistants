(define (max-events-ii events k)
  (define N (length events))

  ; Sort events by start day. If start days are equal, order doesn't strictly matter for correctness
  ; but consistent sorting is good practice.
  (define sorted-events-list (sort events (lambda (e1 e2) (< (list-ref e1 0) (list-ref e2 0)))))
  ; Convert to vector for O(1) access in binary search and main DP loop.
  (define sorted-events-vec (list->vector sorted-events-list))

  ; Memoization table: memo[idx][k_count]
  ; Initialize with -1 to indicate uncomputed states.
  (define memo (make-vector N))
  (for ([i (in-range N)])
    (vector-set! memo i (make-vector (+ k 1) -1)))

  ; Binary search helper to find the next event.
  ; Returns the index of the first event that starts AFTER current-end-day
  ; within the range [search-start-idx, N-1].
  ; If no such event is found, returns N, which acts as an out-of-bounds index.
  (define (find-next-event-idx current-end-day search-start-idx)
    (let loop ((low search-start-idx) (high (- N 1)) (ans N))
      (if (> low high)
          ans
          (let* ((mid (+ low (quotient (- high low) 2)))
                 (event-mid (vector-ref sorted-events-vec mid))
                 (start-mid (list-ref event-mid 0)))
            (if (> start-mid current-end-day)
                ; This event starts after current-end-day, so it's a potential candidate.
                ; Try to find an earlier one that also satisfies the condition.
                (loop low (- mid 1) mid)
                ; This event does not start after current-end-day, so we need to look later.
                (loop (+ mid 1) high ans))))))

  ; Recursive helper function with memoization.
  ; idx: The current event index we are considering from sorted-events-vec.
  ; k-count: The remaining number of events we can attend.
  (define (solve idx k-count)
    (cond
      ; Base case 1: No more events can be attended.
      ((zero? k-count) 0)
      ; Base case 2: All events have been considered.
      ((>= idx N) 0)
      ; Memoization hit: Return the pre-computed result.
      ((not (= (vector-ref (vector-ref memo idx) k-count) -1))
       (vector-ref (vector-ref memo idx) k-count))
      ; Compute and memoize the result.
      (else
       (let* ((current-event (vector-ref sorted-events-vec idx))
              (event-val (list-ref current-event 2))
              (event-end (list-ref current-event 1))

              ; Option 1: Don't attend the current event.
              ; Move to the next event without decrementing k-count.
              (res1 (solve (+ idx 1) k-count))

              ; Option 2: Attend the current event.
              ; Find the next valid event that starts after the current event ends.
              ; The search for the next event starts from idx + 1.
              (next-idx (find-next-event-idx event-end (+ idx 1)))
              ; Add the current event's value and recursively solve for the next valid event
              ; with one less event allowed.
              (res2 (+ event-val (solve next-idx (- k-count 1))))

              ; Take the maximum of the two options.
              (result (max res1 res2)))
         ; Store the computed result in the memoization table.
         (vector-set! (vector-ref memo idx) k-count result)
         result))))

  ; Start the DP from the first event (index 0) with the initial k.
  (solve 0 k))