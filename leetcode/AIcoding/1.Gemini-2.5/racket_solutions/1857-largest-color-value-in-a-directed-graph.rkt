(define (largest-color-value colors edges)
  (let* ((n (string-length colors))
         (adj (make-vector n '()))
         (in-degree (make-vector n 0))
         ;; dp[u][color_idx] stores the maximum count of color_idx
         ;; in any path ending at node u.
         (dp (make-vector n (make-vector 26 0)))
         ;; Using a vector as a queue for O(1) amortized operations
         (q-vec (make-vector n #f))
         (q-front 0)
         (q-rear 0)
         (nodes-processed 0)
         (max-overall-value 0))

    ;; Helper functions for the queue
    (define (enqueue! item)
      (vector-set! q-vec q-rear item)
      (set! q-rear (+ q-rear 1)))

    (define (dequeue!)
      (let ((item (vector-ref q-vec q-front)))
        (set! q-front (+ q-front 1))
        item))

    (define (queue-empty?)
      (= q-front q-rear))

    ;; Build adjacency list and calculate in-degrees
    (for-each (lambda (edge)
                (let ((u (car edge))
                      (v (cadr edge)))
                  (vector-set! adj u (cons v (vector-ref adj u)))
                  (vector-set! in-degree v (+ (vector-ref in-degree v) 1))))
              edges)

    ;; Initialize queue with nodes having in-degree 0
    (let loop-init-queue ([i 0])
      (when (< i n)
        (when (zero? (vector-ref in-degree i))
          (enqueue! i))
        (loop-init-queue (+ i 1))))

    ;; Topological sort and DP calculation
    (while (not (queue-empty?))
      (let* ((u (dequeue!))
             (u-color-idx (- (char->integer (string-ref colors u)) (char->integer #\a))))

        (set! nodes-processed (+ nodes-processed 1))

        ;; Add the current node's color to its DP state
        (vector-set! (vector-ref dp u) u-color-idx
                     (+ (vector-ref (vector-ref dp u) u-color-idx) 1))

        ;; Update max_overall_value
        (let loop-update-max ([color-idx 0])
          (when (< color-idx 26)
            (set! max-overall-value (max max-overall-value (vector-ref (vector-ref dp u) color-idx)))
            (loop-update-max (+ color-idx 1))))

        ;; Process neighbors
        (for-each (lambda (v)
                    ;; Propagate DP values to neighbors
                    (let loop-propagate-dp ([color-idx 0])
                      (when (< color-idx 26)
                        (let ((path-val-through-u (vector-ref (vector-ref dp u) color-idx))
                              (current-val-at-v (vector-ref (vector-ref dp v) color-idx)))
                          (vector-set! (vector-ref dp v) color-idx (max current-val-at-v path-val-through-u)))
                        (loop-propagate-dp (+ color-idx 1))))

                    ;; Decrement in-degree and enqueue if it becomes 0
                    (vector-set! in-degree v (- (vector-ref in-degree v) 1))
                    (when (zero? (vector-ref in-degree v))
                      (enqueue! v)))
                  (vector-ref adj u))))

    ;; Check for cycles
    (if (= nodes-processed n)
        max-overall-value
        -1)))