#lang racket

(define (cat-and-mouse graph)
  (define N (vector-length graph))

  ;; dp[mouse][cat][turn] stores the outcome of the game from a given state:
  ;; -1: uncomputed
  ;; 0: draw (also used as a temporary marker for "currently computing" to detect cycles)
  ;; 1: mouse wins
  ;; 2: cat wins
  (define dp (make-vector N))
  (for ([i (in-range N)])
    (vector-set! dp i (make-vector N))
    (for ([j (in-range N)])
      (vector-set! (vector-ref dp i) j (make-vector 2 -1))))

  (define (get-dp m c t)
    (vector-ref (vector-ref (vector-ref dp m) c) t))

  (define (set-dp m c t val)
    (vector-set! (vector-ref (vector-ref dp m) c) t val))

  ;; solve: a recursive function to determine the winner for a given state (mouse, cat, turn)
  ;; m: mouse's current position
  ;; c: cat's current position
  ;; t: current turn (0 for mouse, 1 for cat)
  (define (solve m c t)
    ;; 1. Check for immediate win/loss conditions. These are definitive and take precedence.
    (when (= m 0) (set-dp m c t 1)) ; Mouse reaches hole 0, Mouse wins
    (when (= c m) (set-dp m c t 2)) ; Cat catches mouse, Cat wins

    ;; 2. Check memoization table.
    ;;    If the state has already been computed (1 or 2), return that result.
    ;;    If it's currently being computed (0, meaning we entered this state during the current recursion path),
    ;;    then it signifies a cycle, which results in a draw for this path.
    (let ([current-result (get-dp m c t)])
      (when (not (= current-result -1))
        (current-result)))

    ;; 3. Mark the current state as "currently computing" (0 for draw).
    ;;    This is crucial for cycle detection. If we encounter this state again
    ;;    before it's definitively resolved (i.e., its value is still 0),
    ;;    it means a cycle has occurred, and the game results in a draw.
    (set-dp m c t 0)

    (let ([next-states-results '()])
      (if (= t 0) ; Mouse's turn
          (begin
            ;; Mouse can move to any adjacent node
            (for ([next-m (in-list (vector-ref graph m))])
              (set! next-states-results (cons (solve next-m c 1) next-states-results)))

            ;; Mouse's strategy:
            ;; Prioritize winning (1). If not possible, try to draw (0). Otherwise, accept loss (2).
            (if (member 1 next-states-results)
                (set-dp m c t 1)
                (if (member 0 next-states-results)
                    (set-dp m c t 0)
                    (set-dp m c t 2))))
          ; Cat's turn
          (begin
            ;; Cat can move to any adjacent node, but cannot enter hole 0
            (for ([next-c (in-list (vector-ref graph c))])
              (when (not (= next-c 0))
                (set! next-states-results (cons (solve m next-c 0) next-states-results))))

            ;; Cat's strategy:
            ;; Prioritize winning (2). If not possible, try to draw (0). Otherwise, accept loss (1).
            (if (member 2 next-states-results)
                (set-dp m c t 2)
                (if (member 0 next-states-results)
                    (set-dp m c t 0)
                    (set-dp m c t 1)))))
      ;; Return the final determined value for this state
      (get-dp m c t)))

  ;; The game starts with the mouse at node 1, the cat at node 2, and it's the mouse's turn (0).
  (solve 1 2 0))