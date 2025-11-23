#lang racket

(define (make-fenwick-tree size)
  ;; Fenwick tree (BIT) is 1-indexed internally, so size+1 vector
  (make-vector (+ size 1) 0))

(define (fenwick-update tree idx delta)
  ;; idx is 0-indexed rank, convert to 1-indexed for BIT
  (let loop ((i (+ idx 1)))
    (when (<= i (vector-length tree))
      (vector-set! tree i (+ (vector-ref tree i) delta))
      (loop (+ i (bitwise-and i (- i)))))))

(define (fenwick-query tree idx)
  ;; idx is 0-indexed rank, convert to 1-indexed for BIT
  (let loop ((i (+ idx 1)) (sum 0))
    (when (> i 0)
      (loop (bitwise-and i (- i)) (+ sum (vector-ref tree i))))))

(define (sum-of-imbalance-numbers nums)
  (let* ((n (length nums))
         (nums-vec (list->vector nums))
         ;; Coordinate compression
         (all-values (sort (remove-duplicates (list->set nums)) <))
         (rank-map (make-hash))
         (m (length all-values)))

    ;; Populate rank-map: value -> 0-indexed rank
    (for-each (lambda (val idx) (hash-set! rank-map val idx))
              all-values
              (range m))

    (let ((total-imbalance 0))
      ;; Iterate through all possible starting indices 'p' for the left element of a pair
      (for ((p (in-range n)))
        (let ((fenwick (make-fenwick-tree m)))
          ;; Iterate through all possible ending indices 'q' for the right element of a pair
          (for ((q (in-range (+ p 1) n)))
            ;; If q-1 is strictly between p and q, add nums[q-1] to the Fenwick tree
            ;; This means q must be at least p+2 for an intermediate element to exist
            (when (> q (+ p 1))
              (let ((val-at-q-minus-1 (vector-ref nums-vec (- q 1))))
                (fenwick-update fenwick (hash-ref rank-map val-at-q-minus-1) 1)))

            ;; Check if (nums[p], nums[q]) forms a valid imbalance pair
            (when (> (vector-ref nums-vec p) (vector-ref nums-vec q))
              (let* ((val-p (vector-ref nums-vec p))
                     (val-q (vector-ref nums-vec q))
                     (rank-p (hash-ref rank-map val-p))
                     (rank-q (hash-ref rank-map val-q)))

                ;; Query Fenwick tree for count of elements with ranks
                ;; strictly between rank-q and rank-p (0-indexed exclusive range)
                ;; This corresponds to querying ranks from (rank-q + 1) up to (rank-p - 1)
                (let ((count-intermediate (- (fenwick-query fenwick (sub rank-p 1))
                                             (fenwick-query fenwick rank-q))))
                  ;; If no intermediate elements are found
                  (when (= count-intermediate 0)
                    ;; This pair (p,q) contributes to all subarrays nums[i...j]
                    ;; where i <= p and j >= q.
                    ;; Number of such subarrays is (p - 0 + 1) * (n - 1 - q + 1) = (p + 1) * (n - q)
                    (set! total-imbalance (+ total-imbalance (* (+ p 1) (- n q)))))))))))
      total-imbalance)))