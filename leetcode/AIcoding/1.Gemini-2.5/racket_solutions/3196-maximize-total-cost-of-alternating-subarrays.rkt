(define (maximize-total-cost nums)
  (let loop ([nums-list nums]
             [prev-even-cost 0]
             [prev-odd-cost -1000000000000000]) ; A sufficiently small negative number to represent unreachable states
    (if (empty? nums-list)
        (max prev-even-cost prev-odd-cost)
        (let* ([num (car nums-list)]
               ; Calculate current-even-cost: nums[k] is at an even 0-indexed position.
               ; It either starts a new subarray, or extends a subarray where nums[k-1] was at an odd position.
               ; In both cases, nums[k] contributes its value.
               ; The total cost up to nums[k-1] is max(prev-even-cost, prev-odd-cost) if starting new,
               ; or prev-odd-cost if extending.
               ; This simplifies to max(prev-even-cost, prev-odd-cost) + num.
               [current-even-cost (+ (max prev-even-cost prev-odd-cost) num)]

               ; Calculate current-odd-cost: nums[k] is at an odd 0-indexed position.
               ; It must extend a subarray where nums[k-1] was at an even position.
               ; nums[k] contributes 0 to its subarray's cost.
               [current-odd-cost prev-even-cost])
          (loop (cdr nums-list)
                current-even-cost
                current-odd-cost)))))