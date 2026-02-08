#lang racket

(define (create-components-with-same-value vals edges)
  (define n (vector-length vals))
  (define adj (make-vector n '()))

  ;; Build adjacency list
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define total-sum (apply + (vector->list vals)))

  ;; Find all divisors of total-sum
  (define (get-divisors num)
    (define divisors '())
    (for ((i (in-range 1 (+ (isqrt num) 1))))
      (when (zero? (remainder num i))
        (set! divisors (cons i divisors))
        (when (not (= i (/ num i)))
          (set! divisors (cons (/ num i) divisors)))))
    (sort divisors <)) ; Sort in ascending order for target_sum

  (define potential-target-sums (get-divisors total-sum))

  ;; Try each potential target_sum
  (define result
    (for/first ((target-sum (in-list potential-target-sums)))
      (define num-components 0) ; Counter for successfully formed components

      ;; DFS function to check if a target-sum is valid
      ;; Returns the sum of the current subtree if it's less than target-sum,
      ;; 0 if it forms a complete component, or #f if it's impossible.
      (define (dfs node parent)
        (define current-subtree-sum (vector-ref vals node))

        ;; Use a named let loop for iteration with early exit if failure
        (let loop ((neighbors (vector-ref adj node)))
          (when (and neighbors (not (not current-subtree-sum))) ; Continue only if not failed and neighbors exist
            (define neighbor (car neighbors))
            (when (not (= neighbor parent))
              (define child-sum (dfs neighbor node))
              (cond
                ((not child-sum) ; Child subtree failed
                 (set! current-subtree-sum #f)) ; Propagate failure
                (else
                 (set! current-subtree-sum (+ current-subtree-sum child-sum)))))
            (loop (cdr neighbors))))

        (cond
          ((not current-subtree-sum) #f) ; Propagate failure
          ((= current-subtree-sum target-sum)
           (set! num-components (+ num-components 1))
           0) ; This subtree forms a component, its value doesn't propagate up
          ((< current-subtree-sum target-sum)
           current-subtree-sum)
          (else ; (> current-subtree-sum target-sum)
           #f))) ; Impossible to form components with this target-sum

      ;; Start DFS from node 0 (arbitrary root) with a dummy parent -1
      (define final-root-sum (dfs 0 -1))

      (cond
        ((not final-root-sum) #f) ; DFS failed
        ((= final-root-sum 0) ; All nodes successfully partitioned
         (/ total-sum target-sum)) ; Return the number of components
        (else #f)))) ; The root component didn't sum to target-sum (or 0), so it's not a valid partition.

  (if result result 0)) ; Convert #f to 0 if no solution found