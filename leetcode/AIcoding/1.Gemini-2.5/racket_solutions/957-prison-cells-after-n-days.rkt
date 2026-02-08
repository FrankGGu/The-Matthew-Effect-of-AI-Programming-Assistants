(define (prison-cells-after-n-days cells n)
  (if (= n 0)
      cells
      (let loop ((current-cells cells)
                 (day 0)
                 (seen-states (make-hash))) ; Maps cell state (list) to day number

        ; Store the current state and its day number
        (hash-set! seen-states current-cells day)

        ; Helper to calculate the next state based on current-state
        (define (calculate-next-state current-state)
          (cons 0 ; First cell is always 0
                (append
                 (for/list ([i (in-range 1 7)]) ; Calculate middle 6 cells
                   (let ((left (list-ref current-state (- i 1)))
                         (right (list-ref current-state (+ i 1))))
                     (if (= left right) 1 0)))
                 (list 0)))) ; Last cell is always 0

        ; Calculate the state for the next day
        (let ((next-state (calculate-next-state current-cells)))

          ; Check if we have reached N days
          (if (= (+ day 1) n)
              next-state ; If this is the Nth day, return its state

              ; Otherwise, check for cycles
              (let ((prev-seen-day (hash-ref seen-states next-state #f)))
                (if prev-seen-day
                    ; Cycle detected: next-state was seen before on prev-seen-day
                    (let* ((cycle-length (- (+ day 1) prev-seen-day))
                           (remaining-days (- n (+ day 1)))
                           (effective-remaining-days (if (= cycle-length 0) 0 (modulo remaining-days cycle-length))))

                      ; Simulate the remaining effective days starting from the current cycle state
                      (let simulate-remaining ((current next-state)
                                               (k effective-remaining-days))
                        (if (= k 0)
                            current
                            (simulate-remaining (calculate-next-state current) (- k 1)))))

                    ; No cycle yet, continue to the next day
                    (loop next-state (+ day 1) seen-states))))))))