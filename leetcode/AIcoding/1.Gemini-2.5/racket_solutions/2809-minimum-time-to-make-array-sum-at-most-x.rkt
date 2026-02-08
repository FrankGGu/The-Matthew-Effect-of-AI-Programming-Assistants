(require srfi/1)
(require srfi/13)
(require srfi/69)

(define (minimum-time-to-make-array-sum-at-most-x nums1 nums2 x)
  (let* ((n (length nums1))
         (pairs (map list nums1 nums2))
         (sorted-pairs (sort pairs (lambda (a b) (< (cadr a) (cadr b)))))
         (total-sum-n1 (apply + nums1))
         (inf (expt 10 18)) ; A sufficiently large number for infinity

         ;; dp[k] is a hash table mapping v_sum_removed to min_time_cost, for k items chosen
         (dp (make-vector (+ n 1) #f))) 

    ;; Initialize dp[0] to a hash table with one entry: (0 -> 0)
    (let ((h0 (make-hash)))
      (hash-set! h0 0 0)
      (vector-set! dp 0 h0))

    ;; Initialize other dp[k] with empty hash tables
    (for ([k (in-range 1 (+ n 1))])
      (vector-set! dp k (make-hash)))

    (for-each (lambda (pair)
                (let ((v (car pair))
                      (w (cadr pair)))
                  ;; Iterate k from n-1 down to 0.
                  ;; k represents the number of items chosen *before* considering the current item.
                  ;; So, we use dp[k] (old states for k items) to update dp[k+1] (new states for k+1 items).
                  ;; The multiplier for 'w' will be (k+1), as it's the (k+1)-th item being chosen.
                  (for ([k (in-range (- n 1) -1 -1)]) ; k from n-1 down to 0
                    (let ((prev-h (vector-ref dp k))) ; Hash table for k items (before adding current)
                      (when (hash-count prev-h) ; If there are reachable states for k items
                        (let ((target-h (vector-ref dp (+ k 1)))) ; Hash table for k+1 items (to be updated)
                          (hash-for-each (lambda (prev-v-sum prev-time-cost)
                                           (let* ((new-v-sum (+ prev-v-sum v))
                                                  (new-time-cost (+ prev-time-cost (* w (+ k 1))))) ; (k+1) is the count of items chosen
                                             (let ((existing-time (hash-ref target-h new-v-sum inf)))
                                               (when (< new-time-cost existing-time)
                                                 (hash-set! target-h new-v-sum new-time-cost)))))
                                         prev-h)))))))
              sorted-pairs)

    ;; Final calculation of min-total-time
    (let ((min-total-time (if (<= total-sum-n1 x) 0 inf)))
      (for ([k (in-range (+ n 1))]) ; Iterate through number of items chosen (k)
        (let ((h (vector-ref dp k)))
          (hash-for-each (lambda (v-sum time-cost)
                           (let ((current-n1-sum (- total-sum-n1 v-sum)))
                             (when (<= current-n1-sum x)
                               (set! min-total-time (min min-total-time time-cost)))))
                         h)))

      (if (= min-total-time inf) -1 min-total-time)))