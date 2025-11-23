(define (distance-limited-paths n edgeList queries)
  ;; DSU state: parent array and rank array for union-by-rank optimization
  (define parent (make-vector n 0))
  (define ranks (make-vector n 0))

  ;; Initialize DSU for all nodes
  (for ((i (range n)))
    (vector-set! parent i i)
    (vector-set! ranks i 0))

  ;; DSU find operation with path compression
  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ((root (find (vector-ref parent i))))
          (vector-set! parent i root)
          root)))

  ;; DSU union operation with union by rank
  (define (union i j)
    (let ((root-i (find i))
          (root-j (find j)))
      (unless (= root-i root-j)
        (let ((rank-i (vector-ref ranks root-i))
              (rank-j (vector-ref ranks root-j)))
          (cond
            ((< rank-i rank-j) (vector-set! parent root-i root-j))
            ((> rank-i rank-j) (vector-set! parent root-j root-i))
            (else
             (vector-set! parent root-j root-i)
             (vector-set! ranks root-i (+ rank-i 1))))))))

  ;; 1. Store original query indices and sort queries by limit
  (define indexed-queries
    (for/list ((q queries) (idx (in-naturals)))
      (list (list-ref q 0) (list-ref q 1) (list-ref q 2) idx))) ; (u, v, limit, original_idx)

  (define sorted-queries
    (sort indexed-queries (lambda (q1 q2) (< (list-ref q1 2) (list-ref q2 2)))))

  ;; 2. Sort edges by weight
  (define sorted-edge-list
    (sort edgeList (lambda (e1 e2) (< (list-ref e1 2) (list-ref e2 2)))))

  ;; Result vector to store answers in original query order
  (define results (make-vector (length queries) #f))

  ;; Pointer for iterating through sorted edges
  (define edge-ptr 0)
  (define num-edges (length sorted-edge-list))

  ;; 3. Process sorted queries
  (for ((query sorted-queries))
    (let* ((u (list-ref query 0))
           (v (list-ref query 1))
           (limit (list-ref query 2))
           (original-idx (list-ref query 3)))

      ;; Add all edges whose weight is strictly less than the current query's limit
      ;; This is done monotonically because both edges and queries are sorted.
      (let loop ()
        (when (and (< edge-ptr num-edges)
                   (< (list-ref (list-ref sorted-edge-list edge-ptr) 2) limit))
          (let ((edge (list-ref sorted-edge-list edge-ptr)))
            (union (list-ref edge 0) (list-ref edge 1)))
          (set! edge-ptr (+ edge-ptr 1))
          (loop)))

      ;; After adding relevant edges, check if u and v are connected
      (vector-set! results original-idx (= (find u) (find v)))))

  ;; Convert result vector to list as expected by LeetCode
  (vector->list results))