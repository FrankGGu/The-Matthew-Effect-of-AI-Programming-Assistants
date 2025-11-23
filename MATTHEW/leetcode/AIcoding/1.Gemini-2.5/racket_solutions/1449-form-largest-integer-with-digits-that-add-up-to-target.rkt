(define (largest-number-with-target cost target)
  (define dp (make-vector (+ target 1) "-")) ; Initialize dp array with "-" indicating not reachable
  (vector-set! dp 0 "") ; Base case: cost 0 can be achieved with an empty string

  (define (is-better? s1 s2)
    ;; Compares two number strings s1 and s2 to determine if s1 is "larger" than s2.
    ;; "Larger" means more digits, or same number of digits and lexicographically greater.
    (cond
      ((string=? s2 "-") #t) ; s1 is always better than the initial placeholder "-"
      ((> (string-length s1) (string-length s2)) #t) ; More digits is always better
      ((and (= (string-length s1) (string-length s2)) (string>? s1 s2)) #t) ; Same length, lexicographically greater is better
      (else #f)))

  ;; Iterate through all possible target costs from 1 up to the given target
  (for ([t (in-range 1 (+ target 1))])
    ;; Iterate through digits from 1 to 9
    (for ([d (in-range 1 10)])
      (define c (vector-ref cost (- d 1))) ; Get the cost for the current digit d

      ;; If the current cost t is greater than or equal to the digit's cost c
      (when (>= t c)
        (define prev-cost-idx (- t c))
        (define prev-str (vector-ref dp prev-cost-idx)) ; Get the best string for the remaining cost

        ;; If prev-str is not the unreachable placeholder "-"
        (unless (string=? prev-str "-")
          (define candidate-str (string-append prev-str (number->string d))) ; Form a new candidate string

          ;; If the candidate string is better than the current best string for cost t
          (when (is-better? candidate-str (vector-ref dp t))
            (vector-set! dp t candidate-str)))))) ; Update dp[t] with the new best string

  (define result (vector-ref dp target)) ; Get the final result for the given target
  (if (string=? result "-")
      "0" ; If the target is unreachable, return "0"
      result))