#lang racket

(provide (all-defined-out))

(define (check target-power cities k r)
  (define n (vector-length cities))

  ;; 1. Precompute initial power for each city using a sliding window
  ;; initial-power-values[i] stores the power of city i from existing stations
  (define initial-power-values (make-vector n))
  (let ([current-window-sum 0])
    ;; Calculate initial sum for city 0
    ;; The window for city 0 covers cities[0] to cities[min(n-1, r)]
    (for ([j (in-range (min n (+ r 1)))])
      (set! current-window-sum (+ current-window-sum (vector-ref cities j))))
    (vector-set! initial-power-values 0 current-window-sum)

    ;; Calculate sums for subsequent cities using the sliding window technique
    (for ([i (in-range 1 n)])
      ;; Remove element from left if the window slides past it
      (when (>= (- i r 1) 0)
        (set! current-window-sum (- current-window-sum (vector-ref cities (- i r 1)))))
      ;; Add element to right if it's within bounds
      (when (< (+ i r) n)
        (set! current-window-sum (+ current-window-sum (vector-ref cities (+ i r)))))
      (vector-set! initial-power-values i current-window-sum)))

  ;; 2. Simulate adding stations greedily to achieve target-power
  ;; diff-added-effect is a difference array to track the effect of newly added stations
  ;; A station placed at city P affects cities [P-r, P+r].
  ;; If we place 'needed' stations at city (i+r), they affect cities [i, i+2r].
  ;; So, diff-added-effect[i] increases by 'needed', and diff-added-effect[i+2r+1] decreases by 'needed'.
  ;; The size needs to accommodate index i+2r+1, so n + 2r + 1.
  (define diff-added-effect (make-vector (+ n (* 2 r) 1) 0))
  (define total-stations-used 0)
  (define current-added-stations-window-sum 0) ; This tracks the sum of newly added stations within the current city's power window

  ;; Use a named-let for an early exit from the loop
  (named-let loop-return ([i 0])
    (if (< i n)
        (begin
          ;; Update current-added-stations-window-sum based on diff-added-effect
          (set! current-added-stations-window-sum
                (+ current-added-stations-window-sum (vector-ref diff-added-effect i)))

          ;; Calculate the total power for the current city
          (define current-city-total-power
            (+ (vector-ref initial-power-values i) current-added-stations-window-sum))

          ;; If current city's power is below target, add stations
          (when (< current-city-total-power target-power)
            (define needed (- target-power current-city-total-power))
            (set! total-stations-used (+ total-stations-used needed))

            ;; If we've used more stations than allowed, this target-power is not achievable
            (when (> total-stations-used k)
              (loop-return #f)) ; Early exit with #f

            ;; Add 'needed' stations at city (i+r)
            ;; Update current-added-stations-window-sum for the current city
            (set! current-added-stations-window-sum (+ current-added-stations-window-sum needed))
            ;; Mark the end of the effect of these new stations in diff-added-effect
            (define idx-to-decrease (+ i (* 2 r) 1))
            (when (< idx-to-decrease (vector-length diff-added-effect))
              (vector-set! diff-added-effect idx-to-decrease
                           (- (vector-ref diff-added-effect idx-to-decrease) needed))))
          (loop-return (+ i 1))) ; Continue to the next city
        #t))) ; If the loop completes, target-power is achievable

(define (maximize-the-minimum-powered-city cities k r)
  (define n (vector-length cities))
  (define low 0)
  ;; Determine a safe upper bound for binary search (high)
  ;; Max possible power for a single city could be sum of all initial stations + k
  ;; Max sum of cities: 10^5 * 10^9 = 10^14
  ;; Max k: 10^9
  ;; So, max-possible-power is approximately 10^14 + 10^9.
  (define initial-total-power (for/sum ([x (in-vector cities)]) x))
  (define high (+ initial-total-power k))

  (define ans 0)

  ;; Binary search for the maximum achievable minimum power
  (let loop-binary-search ([low low] [high high] [ans ans])
    (if (<= low high)
        (let ([mid (quotient (+ low high) 2)])
          (if (check mid cities k r)
              ;; If mid is achievable, try for a higher minimum power
              (loop-binary-search (+ mid 1) high mid)
              ;; If mid is not achievable, try for a lower minimum power
              (loop-binary-search low (- mid 1) ans)))
        ans)))