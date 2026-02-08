#lang racket/base

(define (number-of-ways k)
  (define MOD 1000000007)
  (define MAX_JUMP_POWER 30) ; j can go from 0 to 30. So 31 distinct values for j.
  (define MAX_STEPS 62) ; Maximum number of total steps (forward + backward) that can keep us within a relevant range.
                        ; This is derived from (MAX_JUMP_POWER + 1) forward jumps and (MAX_JUMP_POWER + 1) backward jumps.
                        ; (30 + 1) * 2 = 62.
  (define DELTA_OFFSET MAX_STEPS) ; Offset to map delta (current_stair - k) to a non-negative array index.
                                  ; delta range is [-MAX_STEPS, MAX_STEPS].
  (define DELTA_SIZE (+ (* 2 MAX_STEPS) 1)) ; Total size of the delta dimension in the memo table (e.g., 125 for 62*2+1).

  ; Memoization table: memo[delta_idx][j][b_idx]
  ; delta_idx: mapped from delta (current_stair - k)
  ; j: power of the last forward jump (0 to MAX_JUMP_POWER)
  ; b_idx: 0 for #f (last move was forward), 1 for #t (last move was backward)
  (define memo (make-vector DELTA_SIZE))
  (for ([i (in-range DELTA_SIZE)])
    (vector-set! (vector-ref memo i)
                 (make-vector (+ MAX_JUMP_POWER 1)))) ; +1 for j=0 to MAX_JUMP_POWER
  (for ([i (in-range DELTA_SIZE)])
    (for ([j-idx (in-range (+ MAX_JUMP_POWER 1))])
      (vector-set! (vector-ref (vector-ref memo i) j-idx)
                   (make-vector 2 #f)))) ; 2 for boolean states

  ; dp function: Calculates number of ways to reach k from (current_stair, last_jump_power, last_move_was_backward?)
  ; delta: current_stair - k
  ; j: last_jump_power
  ; b-val: last_move_was_backward? (#t or #f)
  (define (dp delta j b-val)
    ; Map delta and b-val to array indices
    (define delta-idx (+ delta DELTA_OFFSET))
    (define b-idx (if b-val 1 0))

    ; Check memoization table
    (let ([memo-val (vector-ref (vector-ref (vector-ref memo delta-idx) j) b-idx)])
      (if memo-val
          memo-val ; Return memoized value if present
          (let ([current-ways 0])
            ; If current stair is k (delta = 0), this is one way to reach k.
            (when (= delta 0)
              (set! current-ways (modulo (+ current-ways 1) MOD)))

            ; Option 1: Jump forward
            ; Can jump forward with power j+1, if j has not reached MAX_JUMP_POWER.
            ; If j is MAX_JUMP_POWER, the next jump power (j+1) would be out of our defined range.
            (when (< j MAX_JUMP_POWER)
              (set! current-ways (modulo (+ current-ways
                                            (dp-safe (+ delta (expt 2 (+ j 1))) (+ j 1) #f))
                                          MOD)))

            ; Option 2: Jump backward
            ; Only allowed if the last move was not backward (b-val is #f).
            (when (not b-val)
              (set! current-ways (modulo (+ current-ways
                                            (dp-safe (- delta 1) j #t))
                                          MOD)))

            ; Store and return the computed result
            (vector-set! (vector-ref (vector-ref (vector-ref memo delta-idx) j) b-idx) current-ways)
            current-ways))))

  ; Helper function to call dp, returning 0 if parameters are out of bounds
  ; This prevents recursive calls from going into states that are too far from k
  ; or have an invalid jump power.
  (define (dp-safe delta j b-val)
    (if (or (< delta (- MAX_STEPS)) ; delta too far below k
            (> delta MAX_STEPS)     ; delta too far above k
            (> j MAX_JUMP_POWER))   ; j exceeds max allowed jump power
        0
        (dp delta j b-val)))

  ; Initial call:
  ; The person starts at stair 0.
  ; The first move must be a forward jump of 2^0 = 1 step.
  ; So, the effective starting state for our DP is:
  ;   current_stair = 1
  ;   last_jump_power = 0
  ;   last_move_was_backward? = #f (since it was a forward jump)
  ; The initial delta is (1 - k).
  (dp-safe (- 1 k) 0 #f))