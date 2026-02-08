(define (maximum-points-in-an-archery-competition numArrows bobArrows)
  (let* ([num-zones 12]
         [memo (make-hasheq)] ; Stores (zone_idx . remaining_arrows) -> max_points
         [alice-choices (make-vector num-zones 0)]) ; To store the final aliceArrows

    ; Memoized recursive function to find the maximum points
    (define (find-max-points zone-idx current-arrows-left)
      (cond
        [(= zone-idx num-zones) 0] ; Base case: all zones processed
        [(hash-has-key? memo (cons zone-idx current-arrows-left))
         (hash-ref memo (cons zone-idx current-arrows-left))]
        [else
         ; Option 1: Alice doesn't win this zone
         (let* ([points-if-not-win (find-max-points (+ zone-idx 1) current-arrows-left)]
                [max-points points-if-not-win])

           ; Option 2: Alice tries to win this zone
           (let ([arrows-needed (+ (list-ref bobArrows zone-idx) 1)])
             (when (<= arrows-needed current-arrows-left)
               (let ([points-if-win (+ zone-idx (find-max-points (+ zone-idx 1) (- current-arrows-left arrows-needed)))])
                 (when (> points-if-win max-points)
                   (set! max-points points-if-win)))))

           ; Store and return max-points
           (hash-set! memo (cons zone-idx current-arrows-left) max-points)
           max-points))]))

    ; Call the main DP function to populate the memo table
    (find-max-points 0 numArrows)

    ; Reconstruct the aliceArrows based on the memo table
    (let loop ([zone-idx 0] [current-arrows-left numArrows])
      (when (< zone-idx num-zones)
        (let* ([arrows-needed (+ (list-ref bobArrows zone-idx) 1)]
               [current-max-points (find-max-points zone-idx current-arrows-left)]) ; The known optimal for this state

          (if (and (<= arrows-needed current-arrows-left)
                   (= (+ zone-idx (find-max-points (+ zone-idx 1) (- current-arrows-left arrows-needed)))
                      current-max-points))
              ; Alice wins this zone (it's part of the optimal path)
              (begin
                (vector-set! alice-choices zone-idx arrows-needed)
                (loop (+ zone-idx 1) (- current-arrows-left arrows-needed)))
              ; Alice does not win this zone (it's part of the optimal path)
              (begin
                (vector-set! alice-choices zone-idx 0)
                (loop (+ zone-idx 1) current-arrows-left))))))

    ; Distribute any remaining arrows to zone 0 as it doesn't affect points
    (let ([used-arrows (for/sum ([i (in-range num-zones)]) (vector-ref alice-choices i))])
      (vector-set! alice-choices 0 (+ (vector-ref alice-choices 0) (- numArrows used-arrows))))

    (vector->list alice-choices)))