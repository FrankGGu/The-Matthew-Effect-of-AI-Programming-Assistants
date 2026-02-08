(define (solve n adj k)
  (define MOD 1000000007)

  ; Convert adj list of lists to vector of lists for O(1) access
  (define adj-vec (list->vector adj))

  ; Calculate total number of unique edges E
  (define E 0)
  (for ([i (in-range n)])
    (set! E (+ E (length (vector-ref adj-vec i)))))
  (set! E (quotient E 2)) ; Each edge is counted twice in the sum of degrees

  ; DFS state for cycle detection
  (define visited-for-cycle (make-vector n #f))
  (define has-cycle? #f)

  ; DFS function to detect cycles
  (define (dfs-cycle-detect u parent)
    (vector-set! visited-for-cycle u #t)
    (for-each (lambda (v)
                ; If a cycle is already found, no need to continue exploring
                (when (not has-cycle?)
                  (cond
                    [(= v parent) ; Skip the edge to parent, it's how we came
                     #f]
                    [(vector-ref visited-for-cycle v) ; If v is visited and not parent, a cycle is detected
                     (set! has-cycle? #t)]
                    [else ; If v is not visited, recurse
                     (dfs-cycle-detect v u)])))
              (vector-ref adj-vec u)))

  ; Iterate through all nodes to handle disconnected components
  (for ([i (in-range n)])
    (when (and (not has-cycle?) (not (vector-ref visited-for-cycle i)))
      (dfs-cycle-detect i -1))) ; -1 as initial parent, assuming node IDs are non-negative

  ; If a cycle was detected, return 0
  (if has-cycle?
      0
      ; Otherwise, calculate k^E mod MOD using modular exponentiation
      (let power-mod ([base k] [exp E] [res 1])
        (if (zero? exp)
            res
            (power-mod (modulo (* base base) MOD)
                       (quotient exp 2)
                       (if (odd? exp)
                           (modulo (* res base) MOD)
                           res))))))