#lang racket

(define (maximize-subarrays-after-removing-one-conflicting-pair intervals)
  ;; Add length to each interval: (start end length)
  (define intervals-with-len
    (map (lambda (interval)
           (list (car interval) (cadr interval) (- (cadr interval) (car interval) -1)))
         intervals))

  ;; Sort intervals by end time, then by start time.
  (define sorted-intervals-vec
    (list->vector
     (sort intervals-with-len (lambda (a b)
                                (cond
                                  ((< (cadr a) (cadr b)) #t)
                                  ((> (cadr a) (cadr b)) #f)
                                  (else (< (car a) (car b))))))))

  (define N (vector-length sorted-intervals-vec))

  ;; dp[i] = maximum sum of lengths of non-overlapping intervals from sorted-intervals-vec[0...i-1]
  ;;         without removing any interval.
  (define dp (make-vector (+ N 1) 0))

  ;; dp-removed[i] = maximum sum of lengths of non-overlapping intervals from sorted-intervals-vec[0...i-1]
  ;;                 having removed exactly one interval.
  (define dp-removed (make-vector (+ N 1) 0))

  ;; Helper to find the index of the last interval in sorted-intervals-vec[0...current-idx-1]
  ;; that ends strictly before current-start-time.
  ;; Returns k such that sorted-intervals-vec[k][1] < current-start-time.
  ;; Returns -1 if no such interval exists.
  (define (find-prev-non-overlapping-idx current-start-time current-idx)
    (let loop ((low 0) (high (- current-idx 1)) (ans -1))
      (if (> low high)
          ans
          (let* ((mid (quotient (+ low high) 2))
                 (interval (vector-ref sorted-intervals-vec mid)))
            (if (< (cadr interval) current-start-time)
                (loop (+ mid 1) high mid) ; This interval is non-overlapping, try to find a later one
                (loop low (- mid 1) ans))))))

  (for ((i (in-range N)))
    (define current-interval (vector-ref sorted-intervals-vec i))
    (define s (car current-interval))
    (define len (caddr current-interval))

    ;; --- Calculate dp[i+1] (without removal) ---
    ;; Option 1: Don't include current-interval.
    (define val-dp-exclude (vector-ref dp i))

    ;; Option 2: Include current-interval.
    ;; Find the index of the last non-overlapping interval before current-interval.
    (define prev-k (find-prev-non-overlapping-idx s i))
    (define prev-dp-sum (if (>= prev-k 0) (vector-ref dp (+ prev-k 1)) 0))
    (define val-dp-include (+ len prev-dp-sum))

    (vector-set! dp (+ i 1) (max val-dp-exclude val-dp-include))

    ;; --- Calculate dp-removed[i+1] (with one removal) ---
    ;; Option 1: Don't include current-interval.
    (define val-removed-exclude (vector-ref dp-removed i))

    ;; Option 2: Include current-interval.
    ;;   Sub-option A: The removal happened before current-interval.
    ;;                 current-interval must not overlap with the last chosen interval before it.
    (define prev-dp-removed-sum (if (>= prev-k 0) (vector-ref dp-removed (+ prev-k 1)) 0))
    (define val-removed-include-prev-removed (+ len prev-dp-removed-sum))

    ;;   Sub-option B: The removal happens *now* to resolve a conflict involving current-interval.
    ;;                 This means we include current-interval, and we take the best sum of intervals
    ;;                 up to `intervals[i-1]` (without any prior removals, i.e., `dp[i]`).
    ;;                 If `current-interval` conflicts with any interval in the `dp[i]` sequence,
    ;;                 we use our single removal allowance to remove one such conflicting interval.
    (define val-removed-include-now-removed (+ len (vector-ref dp i)))

    (vector-set! dp-removed (+ i 1)
                 (max val-removed-exclude val-removed-include-prev-removed val-removed-include-now-removed)))

  ;; The final answer is the maximum of the two states at the end.
  (max (vector-ref dp N) (vector-ref dp-removed N)))