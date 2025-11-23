(define (min-cost-connect-points points-list)
  (define n (length points-list))

  ;; Handle cases for 0 or 1 point.
  ;; For n=1, the cost to connect is 0. For n=0, it's an invalid input based on typical constraints.
  (when (<= n 1)
    (if (= n 0) (error "Input must have at least 1 point") 0))

  ;; Convert list of lists to vector of lists for O(1) access
  (define points (list->vector points-list))

  ;; Function to calculate Manhattan distance between two points
  (define (manhattan-distance p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cadr p1) (cadr p2)))))

  ;; Generate all possible edges with their weights
  (define edges '())
  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (set! edges (cons (list (manhattan-distance (vector-ref points i) (vector-ref points j)) i j) edges))))

  ;; Sort edges by weight in ascending order
  (set! edges (sort edges (lambda (e1 e2) (< (car e1) (car e2)))))

  ;; Disjoint Set Union (DSU) data structure
  (define parent (make-vector n))
  (define rank (make-vector n 0)) ; Used for union by rank heuristic

  ;; Initialize DSU: each element is its own parent
  (for ([i (in-range n)])
    (vector-set! parent i i))

  ;; Find operation with path compression
  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (begin
          (vector-set! parent i (find (vector-ref parent i)))
          (vector-ref parent i))))

  ;; Union operation by rank
  ;; Returns #t if a union occurred (i.e., i and j were in different sets), #f otherwise.
  (define (union i j)
    (define root-i (find i))
    (define root-j (find j))
    (unless (= root-i root-j)
      (define rank-i (vector-ref rank root-i))
      (define rank-j (vector-ref rank root-j))
      (cond
        ((< rank-i rank-j) (vector-set! parent root-i root-j))
        ((> rank-i rank-j) (vector-set! parent root-j root-i))
        (else
         (vector-set! parent root-j root-i)
         (vector-set! rank root-i (+ rank-i 1))))
      #t))

  ;; Kruskal's algorithm to find the Minimum Spanning Tree (MST)
  (define min-cost 0)
  (define num-edges-connected 0)

  (for ([edge edges])
    (define weight (car edge))
    (define u (cadr edge))
    (define v (caddr edge))
    (when (union u v) ; If adding this edge connects two previously unconnected components
      (set! min-cost (+ min-cost weight))
      (set! num-edges-connected (+ num-edges-connected 1))
      ;; Optimization: an MST for N vertices has exactly N-1 edges.
      ;; Once N-1 edges are connected, we have found the MST.
      (when (= num-edges-connected (- n 1))
        (break)))) ; Exit the loop early

  min-cost)