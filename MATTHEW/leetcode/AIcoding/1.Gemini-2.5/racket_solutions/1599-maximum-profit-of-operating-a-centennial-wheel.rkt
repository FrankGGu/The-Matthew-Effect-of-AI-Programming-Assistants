(define (max-profit-of-operating-a-centennial-wheel customers boardingCost runningCost)
  (let* ([num-customers (vector-length customers)]
         [max-profit (make-box -1000000001)] ; A sufficiently small number to ensure any actual profit is greater
         [max-rotations (make-box -1)]     ; Sentinel: -1 means no rotations have occurred yet
         [current-profit (make-box 0)]
         [current-rotations (make-box 0)]
         [waiting-customers (make-box 0)]
         [customer-idx (make-box 0)])

    (let loop ()
      (when (or (< (unbox customer-idx) num-customers)
                (> (unbox waiting-customers) 0))

        ;; Step 1: New customers arrive
        (when (< (unbox customer-idx) num-customers)
          (set-box! waiting-customers (+ (unbox waiting-customers) (vector-ref customers (unbox customer-idx))))
          (set-box! customer-idx (+ (unbox customer-idx) 1)))

        ;; Step 2: Run the wheel if there are waiting customers
        (when (> (unbox waiting-customers) 0)
          (let* ([boarded-count (min (unbox waiting-customers) 16)])
            (set-box! waiting-customers (- (unbox waiting-customers) boarded-count))
            (set-box! current-profit (+ (unbox current-profit) (- (* boarded-count boardingCost) runningCost)))
            (set-box! current-rotations (+ (unbox current-rotations) 1))

            ;; Update max-profit and max-rotations
            (when (> (unbox current-profit) (unbox max-profit))
              (set-box! max-profit (unbox current-profit))
              (set-box! max-rotations (unbox current-rotations)))
            ;; If current-profit is equal to max-profit, we want the minimum rotations.
            ;; Since current-rotations is strictly increasing, the first time a given max-profit
            ;; is achieved will inherently have the minimum rotations for that profit.
            ;; Thus, no update is needed if (unbox current-profit) == (unbox max-profit).
            ))
        (loop)))

    ;; After the loop, check if any rotations actually happened.
    ;; If max-rotations is still -1, it means no customers ever boarded,
    ;; so the profit is 0 with 0 rotations.
    (if (= (unbox max-rotations) -1)
        0
        (unbox max-rotations))))