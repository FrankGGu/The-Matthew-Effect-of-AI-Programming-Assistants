(define (stone-game-ix stones)
  (let ((c0 0)
        (c1 0)
        (c2 0))
    (for-each (lambda (stone)
                (case (remainder stone 3)
                  (0 (set! c0 (+ c0 1)))
                  (1 (set! c1 (+ c1 1)))
                  (2 (set! c2 (+ c2 1)))))
              stones)

    (cond
      ;; Case 1: No stones of type 1 or 2. Alice cannot make a valid first move from S=0.
      ((and (= c1 0) (= c2 0)) #f)

      ;; Case 2: Both type 1 and type 2 stones are available.
      ;; Alice can always win. She picks a stone of type 1 (S=1).
      ;; Bob must then pick a stone of type 2 (S=0) to avoid losing immediately, and he loses.
      ;; Or Bob picks a stone of type 1 (S=2), then Alice picks a stone of type 2 (S=0), Alice loses.
      ;; The winning strategy for Alice:
      ;; Alice picks a stone of type 1 (S=1).
      ;; Bob's turn, S=1. Bob can pick a stone of type 0 (S=1), or type 1 (S=2), or type 2 (S=0, Bob loses).
      ;; Bob will never pick a type 2 stone.
      ;; If Bob picks type 0 (if c0 > 0): S=1. Alice's turn. Alice still has type 2 stones. She picks type 2 (S=0). Alice loses.
      ;; This is wrong. Alice wants Bob to lose.
      ;; If Alice picks 1 (S=1).
      ;; Bob's turn. Bob has c1-1, c2, c0.
      ;; If Bob picks 2 (S=0), Bob loses. Alice wins.
      ;; If Bob picks 1 (S=2), c1-1 becomes c1-2.
      ;;   Alice's turn. Alice has c1-2, c2, c0. S=2.
      ;;   Alice picks 2 (S=1), c2 becomes c2-1.
      ;;   Bob's turn. Bob has c1-2, c2-1, c0. S=1.
      ;;   Bob picks 2 (S=0), Bob loses. Alice wins.
      ;; This strategy ensures Alice wins if c1 >= 1 and c2 >= 1.
      ((and (> c1 0) (> c2 0)) #t)

      ;; Case 3: Only type 1 stones (and type 0 stones) are available.
      ((= c2 0) ; c1 > 0 must be true
       (cond
         ((= c1 1) ; Only one type 1 stone.
          ;; Alice picks the type 1 stone (S=1).
          ;; Bob's turn, S=1. Bob has no type 1 or 2 stones.
          ;; If c0 > 0, Bob picks a type 0 stone (S=1). c0 decreases.
          ;; Alice's turn, S=1. Alice has no type 1 or 2 stones.
          ;; If c0 > 0, Alice picks a type 0 stone (S=1). c0 decreases.
          ;; This continues until c0 runs out.
          ;; The player who is forced to pick a stone (type 0, none left) or has no safe moves (type 1/2, none left) loses.
          ;; The problem states: "If the game ends and no player has made the sum a multiple of 3, the current player wins."
          ;; This means if a player cannot make a move, the *other* player wins.
          ;; If c0 is even, Alice takes the last 0-stone, Bob has no moves, Bob wins. Alice loses.
          ;; If c0 is odd, Bob takes the last 0-stone, Alice has no moves, Alice wins.
          ;; So, Alice wins if c0 is odd.
          (odd? c0))
         (else ; c1 > 1. Alice loses.
          ;; Alice picks type 1 (S=1). c1 decreases.
          ;; Bob picks type 1 (S=2). c1 decreases.
          ;; Alice's turn, S=2. Alice must pick type 1 (S=0). Alice loses.
          ;; This happens if c1 >= 2.
          #f)))

      ;; Case 4: Only type 2 stones (and type 0 stones) are available.
      ((= c1 0) ; c2 > 0 must be true
       (cond
         ((= c2 1) ; Only one type 2 stone. Symmetric to c1=1.
          ;; Alice picks type 2 (S=2).
          ;; Bob's turn, S=2. Bob has no type 1 or 2 stones.
          ;; If c0 > 0, Bob picks type 0 (S=2). c0 decreases.
          ;; Alice's turn, S=2. Alice has no type 1 or 2 stones.
          ;; If c0 > 0, Alice picks type 0 (S=2). c0 decreases.
          ;; This continues until c0 runs out.
          ;; If c0 is odd, Bob takes the last 0-stone, Alice has no moves, Alice wins.
          ;; If c0 is even, Alice takes the last 0-stone, Bob has no moves, Bob wins. Alice loses.
          ;; So, Alice wins if c0 is odd.
          (odd? c0))
         (else ; c2 > 1. Alice loses. Symmetric to c1 > 1.
          ;; Alice picks type 2 (S=2). c2 decreases.
          ;; Bob picks type 2 (S=1). c2 decreases.
          ;; Alice's turn, S=1. Alice must pick type 2 (S=0). Alice loses.
          ;; This happens if c2 >= 2.
          #f)))
      )))