(define (max-path-quality values edges maxTime)
  (define n (vector-length values))

  ;; Build adjacency list
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (list-ref edge 0))
                    (v (list-ref edge 1))
                    (time (list-ref edge 2)))
                (vector-set! adj u (cons (list v time) (vector-ref adj u)))
                (vector-set! adj v (cons (list u time) (vector-ref adj v)))))
            edges)

  ;; Global variable to store the maximum quality found
  ;; Initialize with the value of node 0, as it's always part of the path.
  (define max-quality (vector-ref values 0))

  ;; visited-counts[i] stores how many times node i has been visited in the current path.
  ;; This is used to correctly calculate unique node values for path quality and for backtracking.
  (define visited-counts (make-vector n 0))

  ;; DFS function
  (define (dfs current-node current-time current-path-quality)
    ;; Update max-quality with the current path's quality.
    ;; This update happens unconditionally, based on interpreting the example output
    ;; where the path does not necessarily end at node 0 for its quality to be considered.
    (set! max-quality (max max-quality current-path-quality))

    ;; Explore neighbors
    (for-each (lambda (edge-info)
                (let ((neighbor (car edge-info))
                      (time-cost (cadr edge-info)))
                  (let ((new-time (+ current-time time-cost)))
                    (when (<= new-time maxTime)
                      ;; Check if neighbor is being visited for the first time in this path
                      (let ((is-newly-visited (= (vector-ref visited-counts neighbor) 0)))
                        ;; Increment visit count for neighbor
                        (vector-set! visited-counts neighbor (+ (vector-ref visited-counts neighbor) 1))

                        ;; Calculate new path quality: add value only if newly visited
                        (let ((new-path-quality (if is-newly-visited
                                                    (+ current-path-quality (vector-ref values neighbor))
                                                    current-path-quality)))
                          ;; Recurse
                          (dfs neighbor new-time new-path-quality))

                        ;; Backtrack: Decrement visit count for neighbor
                        (vector-set! visited-counts neighbor (- (vector-ref visited-counts neighbor) 1))))))))
              (vector-ref adj current-node)))

  ;; Initial call for DFS
  ;; Start at node 0, time 0.
  ;; Mark node 0 as visited and pass its value as the initial quality.
  (vector-set! visited-counts 0 1)
  (dfs 0 0 (vector-ref values 0))
  ;; Backtrack for the initial node 0 (optional, as the function is about to return)
  (vector-set! visited-counts 0 0)

  max-quality)