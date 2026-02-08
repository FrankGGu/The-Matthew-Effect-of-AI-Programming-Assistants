(define (min-k-flips A K)
  (let* ((n (length A))
         (A-vec (list->vector A)) ; Convert list to mutable vector for O(1) access/update
         (flip-starts (make-vector n 0)) ; 0 if no flip started, 1 if flip started
         (num-flips 0)
         (current-active-flips 0)
         (possible #t)) ; Flag to track if it's possible

    (for ([i (in-range n)] #:when possible)
      ;; Update current-active-flips by removing expired flips
      (when (>= i K)
        (when (= (vector-ref flip-starts (- i K)) 1)
          (set! current-active-flips (- current-active-flips 1))))

      ;; Determine the effective value of A[i]
      ;; An odd number of active flips means A[i] is flipped
      (let* ((original-val (vector-ref A-vec i))
             (effective-val (if (even? current-active-flips)
                                original-val
                                (if (= original-val 0) 1 0)))) ; XOR with 1 if odd flips

        (when (= effective-val 0)
          ;; If effective-val is 0, we must initiate a flip starting at 'i'
          (when (> (+ i K) n) ; Check if flipping from 'i' goes out of bounds
            (set! possible #f)) ; Mark as impossible

          (when possible ; Only proceed if still possible
            (set! num-flips (+ num-flips 1))
            (set! current-active-flips (+ current-active-flips 1))
            (vector-set! flip-starts i 1)))) ; Mark that a flip started at 'i'
    ) ; End for loop

    (if possible num-flips -1)))