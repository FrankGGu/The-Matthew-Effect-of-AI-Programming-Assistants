(define (minimum-seconds nums)
  (define n (length nums))

  ;; Step 1: Group indices by value
  ;; val-to-indices: hash-table (value -> list-of-indices-in-reverse-order)
  (define val-to-indices (make-hash))
  (for ([i (in-range n)])
    (hash-update! val-to-indices
                  (list-ref nums i)
                  (lambda (current-list) (cons i current-list))
                  '()))

  ;; Step 2: Calculate minimum seconds required for each unique value
  ;; and find the overall minimum.
  (define min-total-seconds +inf.0)

  (for ([(val indices-rev) val-to-indices])
    (define indices (reverse indices-rev)) ; Get indices in ascending order
    (define k (length indices))

    (define current-seconds 0)
    (when (< k n) ; If k == n, all elements are already 'val', so 0 seconds.
      (define max-gap-for-val 0)

      ;; Calculate gaps between consecutive indices in the linear array
      (for ([j (in-range (- k 1))])
        (define p_j (list-ref indices j))
        (define p_j+1 (list-ref indices (+ j 1)))
        (define gap (- p_j+1 p_j))
        (set! max-gap-for-val (max max-gap-for-val gap)))

      ;; Calculate the circular gap (between the last and first index)
      (define first-idx (car indices))
      (define last-idx (list-ref indices (- k 1)))
      (define circular-gap (+ (- n last-idx) first-idx))
      (set! max-gap-for-val (max max-gap-for-val circular-gap))

      ;; The time needed for a value is half of the maximum gap, rounded down.
      (set! current-seconds (floor (/ max-gap-for-val 2))))

    (set! min-total-seconds (min min-total-seconds current-seconds)))

  min-total-seconds)