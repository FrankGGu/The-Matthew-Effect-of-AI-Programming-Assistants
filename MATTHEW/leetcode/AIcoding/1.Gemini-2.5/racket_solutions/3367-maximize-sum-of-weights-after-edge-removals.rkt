(define (maximize-sum-of-weights-after-edge-removals n edges weights)
  ;; Convert weights list to a vector for O(1) access
  (define weights-vec (list->vector weights))

  ;; Build adjacency list
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  ;; Calculate total sum of weights
  (define total-sum (apply + weights))

  ;; Use a continuation to return early from anywhere in the function
  (call/cc
   (lambda (return)
     ;; Check divisibility by 3
     (when (not (= (remainder total-sum 3) 0))
       (return -1))

     (define target-val (/ total-sum 3))

     ;; DFS state
     (define subtree-sum (make-vector n 0))
     (define tin (make-vector n 0))
     (define tout (make-vector n 0))
     (define time-counter (box 0)) ; Use a box for mutable time-counter

     ;; Lists to store nodes that form components of target_val or 2*target_val
     (define found-target-sum-nodes '())
     (define found-two-target-sum-nodes '())

     ;; DFS function
     (define (dfs u p)
       (set-box! time-counter (+ (unbox time-counter) 1))
       (vector-set! tin u (unbox time-counter))

       (let loop ((neighbors (vector-ref adj u))
                  (current-node-sum (vector-ref weights-vec u)))
         (if (null? neighbors)
             (begin
               (vector-set! subtree-sum u current-node-sum)
               (set-box! time-counter (+ (unbox time-counter) 1))
               (vector-set! tout u (unbox time-counter))
               current-node-sum)
             (let* ((v (car neighbors))
                    (remaining-neighbors (cdr neighbors)))
               (if (= v p)
                   (loop remaining-neighbors current-node-sum)
                   (loop remaining-neighbors (+ current-node-sum (dfs v u)))))))
     )

     ;; Call DFS from root 0 with parent -1 (dummy parent)
     (dfs 0 -1)

     ;; Populate found-target-sum-nodes and found-two-target-sum-nodes
     (for ((i (in-range n)))
       (when (not (= i 0)) ; Exclude root node 0
         (cond
           ((= (vector-ref subtree-sum i) target-val)
            (set! found-target-sum-nodes (cons i found-target-sum-nodes)))
           ((= (vector-ref subtree-sum i) (* 2 target-val))
            (set! found-two-target-sum-nodes (cons i found-two-target-sum-nodes))))))

     ;; Helper to check if v is a descendant of u
     (define (is-descendant? u v)
       (and (< (vector-ref tin u) (vector-ref tin v))
            (< (vector-ref tout v) (vector-ref tout u))))

     ;; Check Case 1: subtree_sum[u] == 2*target_val and subtree_sum[v] == target_val, v descendant of u
     (for-each (lambda (u)
                 (for-each (lambda (v)
                             (when (is-descendant? u v)
                               (return target-val)))
                           found-target-sum-nodes))
               found-two-target-sum-nodes)

     ;; Check Case 2: subtree_sum[u] == target_val and subtree_sum[v] == target_val, u and v not ancestor/descendant
     (for-each (lambda (u)
                 (for-each (lambda (v)
                             (when (and (not (= u v))
                                        (not (is-descendant? u v))
                                        (not (is-descendant? v u)))
                               (return target-val)))
                           found-target-sum-nodes))
               found-target-sum-nodes)

     ;; If no such pair found
     -1)))