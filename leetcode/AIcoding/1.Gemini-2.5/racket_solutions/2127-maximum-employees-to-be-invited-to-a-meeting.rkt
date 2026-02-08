#lang racket

(define (maximum-employees-to-be-invited-to-a-meeting favorite)
  (define n (vector-length favorite))

  ;; Step 1: Build reverse adjacency list
  (define rev-adj (build-vector n (lambda (i) '())))
  (for ([i (in-range n)])
    (vector-set! rev-adj (vector-ref favorite i) (cons i (vector-ref rev-adj (vector-ref favorite i)))))

  ;; Step 2: Cycle detection and classification
  (define visited-global (make-vector n 0)) ; 0: unvisited, 1: visiting, 2: visited
  (define is-cycle-node (make-vector n #f))
  (define sum-long-cycles 0)
  (define two-cycles '()) ; List of (node1 node2) pairs for 2-cycles

  (for ([i (in-range n)])
    (when (= (vector-ref visited-global i) 0)
      (define current-path '())
      (define curr i)

      ;; Traverse the path until an already visited node is encountered
      (let loop ()
        (when (= (vector-ref visited-global curr) 0)
          (vector-set! visited-global curr 1) ; Mark as visiting
          (set! current-path (cons curr current-path))
          (set! curr (vector-ref favorite curr))
          (loop)))

      (when (= (vector-ref visited-global curr) 1) ; Cycle found (curr is the start of the cycle)
        (define cycle-len 0)
        (define cycle-nodes '())

        ;; Extract cycle nodes from current-path
        (let find-cycle-nodes ([p current-path])
          (when (and (not (null? p)) (not (eq? (car p) curr)))
            (set! cycle-nodes (cons (car p) cycle-nodes))
            (find-cycle-nodes (cdr p))))
        (set! cycle-nodes (cons curr cycle-nodes)) ; Add the starting node of the cycle

        (set! cycle-len (length cycle-nodes))

        (for ([node cycle-nodes])
          (vector-set! is-cycle-node node #t))

        (if (= cycle-len 2)
            (set! two-cycles (cons (list (car cycle-nodes) (cadr cycle-nodes)) two-cycles))
            (set! sum-long-cycles (+ sum-long-cycles cycle-len))))

      ;; Mark all nodes in current-path as fully visited (status 2)
      (for ([node current-path])
        (vector-set! visited-global node 2))))

  ;; Step 3: Calculate max path length (depth) for each node
  ;; depth[u] = length of longest path p_k -> ... -> p_1 -> u where p_1, ..., p_k are NOT cycle nodes.
  ;; This includes u itself.
  (define depth (make-vector n 0))
  (define visited-dp-status (make-vector n 0)) ; 0: unvisited, 1: visiting, 2: visited

  (define (calc-max-path u)
    (cond
      [(= (vector-ref visited-dp-status u) 2) (vector-ref depth u)] ; Already computed
      [(= (vector-ref visited-dp-status u) 1) ; Currently on recursion stack (cycle in dependency)
       ;; This case implies `u` is a cycle node and we're trying to compute its depth
       ;; through a path that includes `u` itself. For cycle nodes, the base depth is 1.
       (if (vector-ref is-cycle-node u)
           1
           ;; This branch should ideally not be reached if cycle detection is correct,
           ;; as a non-cycle node should not form a dependency cycle.
           0)]
      [else
       (vector-set! visited-dp-status u 1) ; Mark as visiting
       (define val 0)
       (if (vector-ref is-cycle-node u)
           ;; For cycle nodes, consider paths from non-cycle predecessors
           (for ([v (vector-ref rev-adj u)])
             (unless (vector-ref is-cycle-node v)
               (set! val (max val (calc-max-path v)))))
           ;; For non-cycle nodes, follow the favorite chain
           (set! val (calc-max-path (vector-ref favorite u))))

       (vector-set! depth u (+ 1 val))
       (vector-set! visited-dp-status u 2) ; Mark as visited
       (vector-ref depth u)]))

  (for ([i (in-range n)])
    (calc-max-path i))

  ;; Step 4: Calculate sum of contributions from 2-cycles with tails
  (define sum-two-cycles-with-tails 0)
  (for ([pair two-cycles])
    (set! sum-two-cycles-with-tails (+ sum-two-cycles-with-tails (vector-ref depth (car pair)) (vector-ref depth (cadr pair)))))

  ;; Step 5: Result is max of sum_long_cycles and sum_two_cycles_with_tails
  (max sum-long-cycles sum-two-cycles-with-tails))