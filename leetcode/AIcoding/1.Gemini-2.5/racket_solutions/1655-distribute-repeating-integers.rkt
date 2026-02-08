(define (can-distribute nums quantity)
  ;; Step 1: Count frequencies of numbers in nums
  (define counts-map (make-hash))
  (for-each (lambda (n)
              (hash-set! counts-map n (+ (hash-ref counts-map n 0) 1)))
            nums)

  ;; Convert hash map values to a list of counts
  (define item-counts-list (hash-values counts-map))
  ;; Convert to a mutable vector for easier updates in recursion
  (define item-counts-vec (list->vector item-counts-list))

  ;; Sort quantity in descending order for optimization
  (define sorted-quantity (sort quantity >))

  ;; Number of customers
  (define m (length sorted-quantity))
  ;; Number of distinct items
  (define n-items (vector-length item-counts-vec))

  ;; Recursive helper function
  ;; current-customer-idx: index of the customer we are currently trying to satisfy
  (define (solve current-customer-idx)
    ;; Base case: All customers have been satisfied
    (if (= current-customer-idx m)
        #t
        ;; Recursive step: Try to satisfy the current customer
        (let* ((q (list-ref sorted-quantity current-customer-idx)))
          ;; Iterate through available item types
          ;; for/or short-circuits and returns #t as soon as any iteration returns #t
          (for/or ([i (in-range n-items)])
            (let ((current-item-count (vector-ref item-counts-vec i)))
              (when (>= current-item-count q)
                ;; If current item type has enough stock, try to use it
                (vector-set! item-counts-vec i (- current-item-count q))
                ;; Recurse for the next customer
                (when (solve (+ current-customer-idx 1))
                  ;; If the recursive call returns true, we found a solution
                  ;; for this path. No need to backtrack this specific change,
                  ;; just return #t up the call stack.
                  #t)
                ;; If the recursive call returned #f, this path didn't work.
                ;; Backtrack: Restore the item count for the current item type.
                (vector-set! item-counts-vec i current-item-count)))))))

  ;; Start the recursion from the first customer
  (solve 0))