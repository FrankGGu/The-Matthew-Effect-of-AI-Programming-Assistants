(define (stone-game-viii stones)
  (define n (vector-length stones))

  ;; P[k] = sum of stones[0]...stones[k-1]
  ;; P is of length n+1, with P[0] = 0.
  (define P (make-vector (+ n 1) 0))
  (for ([k (in-range 1 (+ n 1))])
    (vector-set! P k (+ (vector-ref P (- k 1)) (vector-ref stones (- k 1)))))

  ;; dp[i] = maximum score if stones[i] is the rightmost stone that is NOT removed.
  ;; This means stones[i] is the rightmost of the two final stones remaining.
  ;; dp is of length n.
  (define dp (make-vector n 0))

  ;; Deque stores pairs (j, value) where value = (dp[j] - P[j+1]).
  ;; The deque maintains elements in decreasing order of 'value'.
  ;; This allows efficient retrieval of max(dp[j] - P[j+1]) for j < i.
  (define dq '()) ; Using a list as a deque: (car dq) is front, (append dq (list x)) is push back.

  ;; Base case for dp[0]: If stones[0] is the rightmost stone not removed,
  ;; and it's also the leftmost, then no stones are picked. Score is 0.
  (vector-set! dp 0 0)

  ;; Add the initial state for j=0 to the deque.
  ;; The value to store is (dp[0] - P[0+1]) = (dp[0] - P[1]).
  (set! dq (list (list 0 (- (vector-ref dp 0) (vector-ref P 1)))))

  ;; Initialize max-score with dp[0].
  (define max-score (vector-ref dp 0))

  ;; Iterate from i = 1 to n-1
  (for ([i (in-range 1 n)])
    ;; The maximum value of (dp[j] - P[j+1]) for j < i is at the front of the deque.
    (define current-max-val-from-dq (cdr (car dq))) ; (car dq) is (j, val)

    ;; Calculate dp[i]:
    ;; dp[i] = P[i] + max(dp[j] - P[j+1]) for j < i
    ;; P[i] represents sum(stones[0]...stones[i-1]).
    ;; P[i] - P[j+1] represents sum(stones[j+1]...stones[i-1]).
    (vector-set! dp i (+ (vector-ref P i) current-max-val-from-dq))

    ;; Update the overall maximum score found so far.
    (set! max-score (max max-score (vector-ref dp i)))

    ;; Prepare the value to be added to the deque for the current i.
    ;; This is (dp[i] - P[i+1]).
    (define current-val-for-dq (- (vector-ref dp i) (vector-ref P (+ i 1))))

    ;; Maintain the monotonic decreasing property of the deque.
    ;; Remove elements from the back of the deque that are less than or equal to current-val-for-dq.
    (let loop ()
      (when (and (not (empty? dq))
                 (<= (cdr (last dq)) current-val-for-dq))
        (set! dq (drop-right dq 1))
        (loop)))

    ;; Add the current element (i, current-val-for-dq) to the back of the deque.
    (set! dq (append dq (list (list i current-val-for-dq)))))

  max-score)