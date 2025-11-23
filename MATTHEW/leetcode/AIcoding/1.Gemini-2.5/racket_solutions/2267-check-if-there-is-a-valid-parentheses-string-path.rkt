(define (has-valid-path grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define total-path-length (+ m n -1))

  ;; If the total path length is odd, it's impossible to form a valid parentheses string.
  (when (odd? total-path-length)
    (hash-set! memo (list r c bal) #f)
    (return #f))

  ;; Check starting and ending characters
  (when (char=? (vector-ref (vector-ref grid 0) 0) #\))
    (return #f))
  (when (char=? (vector-ref (vector-ref grid (- m 1)) (- n 1)) #\()
    (return #f))

  ;; dp[r][c][balance] stores whether it's possible to reach (r, c) with 'balance' open parentheses.
  ;; Max possible balance is total-path-length, which is m+n-1.
  ;; So, balance can go up to m+n-1. Array size needs to be m+n.
  (define max-balance-val (+ m n))
  (define dp (make-vector m (lambda () (make-vector n (lambda () (make-vector max-balance-val #f))))))

  ;; Base case: starting cell (0, 0)
  ;; If grid[0][0] is '(', balance becomes 1.
  (vector-set! (vector-ref (vector-ref dp 0) 0) 1 #t)

  (for* ([r (in-range m)]
         [c (in-range n)])
    (define current-char (vector-ref (vector-ref grid r) c))
    (when (or (> r 0) (> c 0)) ; Skip (0,0) as it's handled by base case
      (for ([prev-bal (in-range max-balance-val)]) ; prev-bal is balance at (r-1,c) or (r,c-1)
        (define can-reach-from-top #f)
        (when (> r 0)
          (set! can-reach-from-top (vector-ref (vector-ref (vector-ref dp (- r 1)) c) prev-bal)))

        (define can-reach-from-left #f)
        (when (> c 0)
          (set! can-reach-from-left (vector-ref (vector-ref (vector-ref dp r) (- c 1)) prev-bal)))

        (when (or can-reach-from-top can-reach-from-left)
          (define current-bal
            (if (char=? current-char #\()
                (+ prev-bal 1)
                (- prev-bal 1)))

          ;; Check if current-bal is valid
          ;; 1. Balance must be non-negative.
          ;; 2. Balance must not exceed the current path length (r+c+1).
          (when (and (>= current-bal 0) (<= current-bal (+ r c 1)) (< current-bal max-balance-val))
            (vector-set! (vector-ref (vector-ref dp r) c) current-bal #t))))))

  ;; The final answer is whether we can reach (m-1, n-1) with a balance of 0.
  (vector-ref (vector-ref (vector-ref dp (- m 1)) (- n 1)) 0))