(define (count-subarrays-with-median-k nums k)
  (let* ([n (vector-length nums)]
         [arr-val (make-vector n)])
    ;; Step 1: Transform nums to arr-val
    ;; 1 if num > k
    ;; 0 if num = k
    ;; -1 if num < k
    (for ([i (in-range n)])
      (let ([num (vector-ref nums i)])
        (cond
          [(> num k) (vector-set! arr-val i 1)]
          [(= num k) (vector-set! arr-val i 0)]
          [else (vector-set! arr-val i -1)])))

    (let ([total-count 0]
          [current-balance 0]
          [freq-left (make-hash)] ; Stores frequencies of prefix sums P[x] where x < k_idx
          [freq-right (make-hash)]) ; Stores frequencies of prefix sums P[x] where x >= k_idx

      (hash-set! freq-left 0 1) ; Represents P[-1] = 0

      (let ([k-found #f])
        (for ([i (in-range n)])
          (let ([val (vector-ref arr-val i)])
            (when (= (vector-ref nums i) k)
              (set! k-found #t))

            ;; Update current-balance (which is P[i])
            (set! current-balance (+ current-balance val))

            (if k-found
                ;; If k has been found, we count subarrays ending at i
                ;; that satisfy the median condition.
                ;; These subarrays can either:
                ;; 1. Start before the first k (using freq-left).
                ;; 2. Start at or after the first k (using freq-right).

                ;; Subarrays [p...i] where p-1 is in freq-left (i.e., p-1 < first_k_idx)
                ;; Sum(arr-val[p...i]) = current-balance - P[p-1].
                ;; We need current-balance - P[p-1] = 0  => P[p-1] = current-balance
                ;; We need current-balance - P[p-1] = 1  => P[p-1] = current-balance - 1
                (begin
                  (set! total-count (+ total-count (hash-ref freq-left current-balance 0)))
                  (set! total-count (+ total-count (hash-ref freq-left (- current-balance 1) 0)))

                  ;; Subarrays [p...i] where p-1 is in freq-right (i.e., p-1 >= first_k_idx)
                  (set! total-count (+ total-count (hash-ref freq-right current-balance 0)))
                  (set! total-count (+ total-count (hash-ref freq-right (- current-balance 1) 0)))

                  ;; Update freq-right with current-balance
                  (hash-update! freq-right current-balance add1 0))

                ;; If k not found yet, just update freq-left
                (hash-update! freq-left current-balance add1 0)))))

    total-count)))