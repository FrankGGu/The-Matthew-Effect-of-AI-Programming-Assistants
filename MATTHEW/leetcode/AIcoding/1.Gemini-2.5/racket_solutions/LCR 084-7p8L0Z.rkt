(define (permute-unique nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define result '())
  (define used (make-vector n #f)) ; Boolean vector to track used elements

  (define (backtrack current-permutation-list)
    (if (= (length current-permutation-list) n)
        ;; Base case: A complete permutation is formed
        (set! result (cons (reverse current-permutation-list) result))
        ;; Recursive step: Iterate through available numbers
        (let loop ([i 0])
          (when (< i n)
            (cond
              [(vector-ref used i) ; If the element at index i is already used, skip it
               (loop (+ i 1))]
              [(and (> i 0) ; If not the first element
                    (= (list-ref sorted-nums i) (list-ref sorted-nums (- i 1))) ; And it's a duplicate of the previous element
                    (not (vector-ref used (- i 1)))) ; And the previous duplicate was NOT used
               ;; Skip this element to avoid duplicate permutations.
               ;; This ensures that for identical numbers, we only pick the first one
               ;; unless the previous identical one has already been picked.
               (loop (+ i 1))]
              [else ; Otherwise, use this element
               (vector-set! used i #t) ; Mark as used
               (backtrack (cons (list-ref sorted-nums i) current-permutation-list)) ; Recurse
               (vector-set! used i #f) ; Backtrack: Mark as unused
               (loop (+ i 1))]))))) ; Move to the next element

  (backtrack '())
  result)