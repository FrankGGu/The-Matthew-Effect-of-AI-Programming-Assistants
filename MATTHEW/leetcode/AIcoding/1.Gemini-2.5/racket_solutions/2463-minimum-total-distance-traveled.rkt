#lang racket

(require data/deque)

(define (minimum-total-distance-traveled robots factories)
  (define N (length robots))
  (define M (length factories))

  ;; Sort robots by position
  (define sorted-robots (sort robots (lambda (r1 r2) (< (car r1) (car r2)))))
  ;; Sort factories by position
  (define sorted-factories (sort factories (lambda (f1 f2) (< (car f1) (car f2)))))

  ;; Calculate prefix sums of robot positions
  ;; P[k] = sum of positions of first k robots (robots[0]...robots[k-1])
  ;; P[0] = 0
  (define P (make-vector (+ N 1) 0))
  (for ([i (in-range N)])
    (vector-set! P (+ i 1) (+ (vector-ref P i) (car (list-ref sorted-robots i)))))

  (define +inf (expt 10 15)) ;; A sufficiently large number for infinity (max total distance ~ 10^12)

  ;; dp[i] will store the minimum cost to repair the first i robots
  ;; prev_dp is dp[...][j-1], curr_dp is dp[...][j]
  (define prev_dp (make-vector (+ N 1) +inf))
  (vector-set! prev_dp 0 0) ;; Base case: 0 robots, 0 cost

  (for ([j (in-range M)]) ;; Iterate through factories
    (define curr_dp (make-vector (+ N 1) +inf))
    (vector-set! curr_dp 0 0) ;; Base case for current factory: 0 robots, 0 cost

    (define current-factory-pos (car (list-ref sorted-factories j)))
    (define current-factory-capacity (cadr (list-ref sorted-factories j)))

    ;; Deque stores (list x g(x)) where g(x) = prev_dp[x] + P[x] - x * current-factory-pos
    (define dq (make-deque)) 

    (for ([i (in-range (+ N 1))]) ;; Iterate through number of robots
      ;; Option 1: Don't use current factory j for robot i (or any robots up to i)
      ;; This means curr_dp[i] is the same as prev_dp[i]
      (when (< (vector-ref prev_dp i) +inf)
        (vector-set! curr_dp i (vector-ref prev_dp i)))

      ;; Add x = i to the deque for g(x) calculation
      ;; g(x) = prev_dp[x] + P[x] - x * current-factory-pos
      ;; Only add if prev_dp[i] is a valid (not +inf) cost
      (when (< (vector-ref prev_dp i) +inf)
        (define val-g-x (+ (vector-ref prev_dp i)
                           (vector-ref P i)
                           (* (- i) current-factory-pos)))
        ;; Maintain monotonic property (increasing g(x) values from front to back)
        ;; If the new value is smaller than the back, the back is no longer useful
        (do ()
            [(or (deque-empty? dq)
                 (> (cadr (deque-peek-back dq)) val-g-x))]
          (deque-pop-back! dq))
        (deque-push-back! dq (list i val-g-x)))

      ;; Remove elements from front of deque that are out of window [max(0, i - current-factory-capacity), i]
      ;; The window for x is [i - current-factory-capacity, i]
      (define min-x-in-window (max 0 (- i current-factory-capacity)))
      (do ()
          [(or (deque-empty? dq)
               (>= (car (deque-peek-front dq)) min-x-in-window))]
        (deque-pop-front! dq))

      ;; If deque is not empty, calculate curr_dp[i] using the best x from deque
      ;; This represents using current factory j to repair (i - x) robots
      (when (not (deque-empty? dq))
        (define best-g-x (cadr (deque-peek-front dq)))
        ;; cost = -P[i] + i * current-factory-pos + best-g-x
        (define cost-using-factory-j (+ (- (vector-ref P i))
                                        (* i current-factory-pos)
                                        best-g-x))
        (vector-set! curr_dp i (min (vector-ref curr_dp i) cost-using-factory-j))))

    (set! prev_dp curr_dp)) ;; Update prev_dp for next factory iteration

  (vector-ref prev_dp N)) ;; The minimum cost to repair all N robots