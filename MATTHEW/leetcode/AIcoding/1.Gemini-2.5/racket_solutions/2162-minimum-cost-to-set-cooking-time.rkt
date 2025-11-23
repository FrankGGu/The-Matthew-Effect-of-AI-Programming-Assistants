(define (min-cost-to-set-cooking-time targetSeconds startAt moveCost pushCost)

  ;; Helper to get the sequence of digits to push, removing leading zeros.
  ;; Examples:
  ;; (get-push-sequence 1 10) -> (1 1 0) for 01:10
  ;; (get-push-sequence 0 5) -> (5) for 00:05
  ;; (get-push-sequence 0 0) -> (0) for 00:00
  (define (get-push-sequence minutes seconds)
    (let* ((m1 (quotient minutes 10))
           (m2 (remainder minutes 10))
           (s1 (quotient seconds 10))
           (s2 (remainder seconds 10))
           (all-digits (list m1 m2 s1 s2)))
      (let remove-leading-zeros ((ds all-digits))
        (cond
          ;; If it's not the last digit and it's zero, remove it.
          ;; This handles leading zeros for numbers like 01:10 (becomes 110) or 00:05 (becomes 5).
          ((and (not (null? (cdr ds))) (= (car ds) 0))
           (remove-leading-zeros (cdr ds)))
          ;; Otherwise, keep the current digit and the rest.
          ;; This also handles the case of (0) for 00:00 correctly.
          (else ds)))))

  ;; Helper to calculate cost for a given sequence of digits.
  (define (calculate-sequence-cost digits current-start-at)
    (let loop ((current-finger-pos current-start-at)
               (remaining-digits digits)
               (cost 0))
      (if (null? remaining-digits)
          cost
          (let* ((next-digit (car remaining-digits))
                 (move-cost-component (if (= current-finger-pos next-digit) 0 moveCost))
                 (push-cost-component pushCost))
            (loop next-digit
                  (cdr remaining-digits)
                  (+ cost move-cost-component push-cost-component))))))

  (let* ((min-val +inf.0) ; Initialize with positive infinity
         (m (quotient targetSeconds 60))
         (s (remainder targetSeconds 60)))

    ;; Candidate 1: m minutes, s seconds
    ;; This representation is valid if 0 <= m <= 99 and 0 <= s <= 99.
    ;; Since s = targetSeconds % 60, s will always be < 60, so s <= 99 is always true.
    (when (<= m 99)
      (set! min-val (min min-val (calculate-sequence-cost (get-push-sequence m s) startAt))))

    ;; Candidate 2: (m-1) minutes, (s+60) seconds
    ;; This representation is valid if 0 <= (m-1) <= 99 and 0 <= (s+60) <= 99.
    (when (and (>= m 1) (<= (+ s 60) 99))
      (let* ((m-prime (- m 1))
             (s-prime (+ s 60)))
        (set! min-val (min min-val (calculate-sequence-cost (get-push-sequence m-prime s-prime) startAt)))))

    min-val))