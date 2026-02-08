(define (max-profit inventory orders)
  (let* ((mod 1000000007)
         (inv-2-mod 500000004) ; Modular inverse of 2 mod 10^9 + 7
         (sorted-inventory-list (sort inventory >))
         (extended-inventory-list (append sorted-inventory-list (list 0)))
         (extended-inventory-vec (list->vector extended-inventory-list))
         (n (length sorted-inventory-list)))

    (define (sum-arithmetic-series start end)
      ;; Calculates (start + (start - 1) + ... + end) mod mod
      ;; Assumes start >= end
      (let* ((n-terms (+ (- start end) 1))
             (s-terms (+ start end)))
        (modulo
         (* (modulo n-terms mod)
            (modulo s-terms mod)
            inv-2-mod)
         mod)))

    (let loop ((i 0)
               (total-value 0)
               (orders-remaining orders))
      (if (or (>= i n) (<= orders-remaining 0))
          total-value
          (let* ((current-val (vector-ref extended-inventory-vec i))
                 (next-val (vector-ref extended-inventory-vec (+ i 1)))
                 (num-colors-at-this-level (+ i 1)) ; Number of colors whose count is >= current-val
                 (diff (- current-val next-val)))

            (if (= diff 0)
                ;; If current-val is same as next-val, no balls to sell at this level
                (loop (+ i 1) total-value orders-remaining)

                (let* ((balls-to-sell-from-each diff)
                       (total-balls-at-this-level (* num-colors-at-this-level balls-to-sell-from-each)))

                  (if (>= orders-remaining total-balls-at-this-level)
                      ;; Enough orders to sell all balls down to next-val + 1 from all applicable colors
                      (let* ((value-for-this-step (sum-arithmetic-series current-val (+ next-val 1)))
                             (added-value (modulo (* num-colors-at-this-level value-for-this-step) mod)))
                        (loop (+ i 1)
                              (modulo (+ total-value added-value) mod)
                              (- orders-remaining total-balls-at-this-level)))

                      ;; Not enough orders to sell all balls down to next-val + 1
                      (let* ((full-steps (quotient orders-remaining num-colors-at-this-level))
                             (remainder-steps (modulo orders-remaining num-colors-at-this-level))
                             (value-after-full-steps (- current-val full-steps))
                             (value-from-full-steps (sum-arithmetic-series current-val (+ value-after-full-steps 1)))
                             (added-value-full (modulo (* num-colors-at-this-level value-from-full-steps) mod))
                             (added-value-remainder (modulo (* remainder-steps value-after-full-steps) mod)))

                        (modulo (+ total-value added-value-full added-value-remainder) mod))))))))))