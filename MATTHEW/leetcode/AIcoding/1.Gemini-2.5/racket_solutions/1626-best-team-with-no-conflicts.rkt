(define (best-team-with-no-conflicts ages scores)
  (define n (vector-length ages))
  (define players (make-vector n))

  ;; Combine ages and scores into a vector of (age score) lists
  (for ([i (in-range n)])
    (vector-set! players i (list (vector-ref ages i) (vector-ref scores i))))

  ;; Sort players:
  ;; 1. Primarily by age in descending order.
  ;; 2. Secondarily by score in descending order (for tie-breaking ages).
  (define sorted-players
    (sort (vector->list players)
          (lambda (p1 p2)
            (let ([age1 (car p1)] [score1 (cadr p1)]
                  [age2 (car p2)] [score2 (cadr p2)])
              (or (> age1 age2)
                  (and (= age1 age2) (> score1 score2)))))))

  ;; Convert sorted-players back to a vector for O(1) access in the DP loop
  (define sorted-players-vec (list->vector sorted-players))

  ;; dp[i] will store the maximum score of a valid team ending with sorted-players-vec[i]
  (define dp (make-vector n))

  (define max-total-score 0)

  (for ([i (in-range n)])
    (let* ([current-player (vector-ref sorted-players-vec i)]
           [current-score (cadr current-player)])
      ;; Initialize dp[i] with the current player's score (a team of just this player)
      (vector-set! dp i current-score)

      ;; Iterate through previous players to find valid team extensions
      (for ([j (in-range i)])
        (let* ([prev-player (vector-ref sorted-players-vec j)]
               [prev-score (cadr prev-player)])
          ;; If previous player's score is greater than or equal to current player's score,
          ;; they can be in the same team without conflict.
          ;; (Age condition is implicitly handled by the initial sort:
          ;; prev-player is either older or the same age as current-player).
          (when (>= prev-score current-score)
            (vector-set! dp i (max (vector-ref dp i)
                                   (+ current-score (vector-ref dp j)))))))
      ;; Update the overall maximum total score found so far
      (set! max-total-score (max max-total-score (vector-ref dp i)))))

  max-total-score)