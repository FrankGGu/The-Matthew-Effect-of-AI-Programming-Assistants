(define (max-height-by-stacking-cuboids cuboids)
  (let* ([n (length cuboids)])
    (if (= n 0)
        0 ; Base case: no cuboids, maximum height is 0
        (let* ([normalized-cuboids
                ;; For each cuboid, sort its dimensions to ensure l <= w <= h.
                ;; This allows consistent comparison for stacking.
                (map (lambda (cuboid)
                       (sort cuboid <))
                     cuboids)]
               [sorted-cuboids
                ;; Sort the normalized cuboids in descending order of dimensions.
                ;; Primary sort key: height (largest dimension) descending.
                ;; Secondary sort key: width (middle dimension) descending.
                ;; Tertiary sort key: length (smallest dimension) descending.
                ;; This ordering ensures that when we consider cuboid_i, any cuboid_j
                ;; that can serve as a base for cuboid_i (i.e., cuboid_j is larger
                ;; in all dimensions) will appear before cuboid_i in the list.
                (sort normalized-cuboids
                      (lambda (c1 c2)
                        (let ([h1 (list-ref c1 2)] [w1 (list-ref c1 1)] [l1 (list-ref c1 0)]
                              [h2 (list-ref c2 2)] [w2 (list-ref c2 1)] [l2 (list-ref c2 0)])
                          (or (> h1 h2)
                              (and (= h1 h2) (> w1 w2))
                              (and (= h1 h2) (= w1 w2) (> l1 l2))))))]
               [dp (make-vector n 0)]) ; dp[i] will store the maximum height of a stack ending with sorted-cuboids[i]

          (let ([max-overall-height 0])
            (for ([i (in-range n)])
              (let* ([current-cuboid (vector-ref sorted-cuboids i)]
                     [current-height (list-ref current-cuboid 2)]) ; The largest dimension acts as height
                (vector-set! dp i current-height) ; Initialize dp[i] with its own height
                ;; Iterate through previous cuboids to find potential bases
                (for ([j (in-range i)])
                  (let* ([prev-cuboid (vector-ref sorted-cuboids j)]
                         [l-top (list-ref current-cuboid 0)]
                         [w-top (list-ref current-cuboid 1)]
                         [h-top (list-ref current-cuboid 2)]
                         [l-bottom (list-ref prev-cuboid 0)]
                         [w-bottom (list-ref prev-cuboid 1)]
                         [h-bottom (list-ref prev-cuboid 2)])
                    ;; Check if current-cuboid (top) can be placed on prev-cuboid (bottom)
                    (when (and (<= l-top l-bottom)
                               (<= w-top w-bottom)
                               (<= h-top h-bottom))
                      ;; If it can be placed, update dp[i] with the maximum possible height
                      ;; by stacking current-cuboid on top of the stack ending at prev-cuboid.
                      (vector-set! dp i (max (vector-ref dp i)
                                             (+ (vector-ref dp j) h-top))))))
                ;; Update the overall maximum height found so far
                (set! max-overall-height (max max-overall-height (vector-ref dp i)))))
            max-overall-height)))))