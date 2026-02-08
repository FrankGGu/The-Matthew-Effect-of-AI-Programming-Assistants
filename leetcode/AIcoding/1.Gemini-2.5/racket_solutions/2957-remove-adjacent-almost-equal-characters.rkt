#lang racket

(define (remove-adjacent-almost-equal-characters s)
  (let* ((n (string-length s))
         (dp (make-vector n))) ; dp[i] stores a list: (min-ops-if-s[i]-kept, min-ops-if-s[i]-removed)

    (when (= n 0)
      (error "Input string cannot be empty based on constraints"))

    ; Base case for i = 0 (first character)
    ; If s[0] is kept, 0 operations.
    ; If s[0] is removed, 1 operation.
    (vector-set! dp 0 (list 0 1))

    ; Iterate from the second character to the end
    (for ([i (in-range 1 n)])
      (let* ((s-curr-code (char->integer (string-ref s i)))
             (s-prev-code (char->integer (string-ref s (- i 1))))
             (prev-dp-vals (vector-ref dp (- i 1)))
             (prev-keep-cost (car prev-dp-vals))
             (prev-remove-cost (cadr prev-dp-vals))
             (current-keep-cost #f)
             (current-remove-cost #f)
             (max-possible-ops (add1 n))) ; A value larger than any possible operation count, acts as infinity

        ; Calculate current-keep-cost (minimum operations to make s[0...i] valid, keeping s[i])
        ; If s[i] is kept, then s[i-1] must either have been removed,
        ; OR s[i-1] was kept AND s[i] is NOT almost-equal to s[i-1].
        (let ((cost-if-prev-removed prev-remove-cost)
              (cost-if-prev-kept (if (> (abs (- s-curr-code s-prev-code)) 1)
                                     prev-keep-cost
                                     max-possible-ops))) ; If almost-equal, cannot keep s[i-1], so cost is infinite

          (set! current-keep-cost (min cost-if-prev-removed cost-if-prev-kept)))

        ; Calculate current-remove-cost (minimum operations to make s[0...i] valid, removing s[i])
        ; If s[i] is removed, the cost is 1 (for removing s[i]) plus the minimum operations
        ; to make s[0...i-1] valid (regardless of whether s[i-1] was kept or removed).
        (set! current-remove-cost (+ 1 (min prev-keep-cost prev-remove-cost)))

        ; Store the calculated costs for the current index i
        (vector-set! dp i (list current-keep-cost current-remove-cost))))

    ; The final answer is the minimum of keeping or removing the last character
    (let ((final-dp-vals (vector-ref dp (- n 1))))
      (min (car final-dp-vals) (cadr final-dp-vals)))))