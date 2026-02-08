(define (count-pairs-of-nodes n edges queries)
  ;; 1. Calculate degrees for all nodes
  (define deg (make-vector n 0))
  (for-each (lambda (edge-pair)
              (define u (vector-ref edge-pair 0))
              (define v (vector-ref edge-pair 1))
              (vector-set! deg u (+ (vector-ref deg u) 1))
              (vector-set! deg v (+ (vector-ref deg v) 1)))
            (vector->list edges))

  ;; 2. Calculate deg-freq: counts of nodes for each degree value
  ;; Max possible degree is n-1.
  (define max-deg (- n 1))
  (define deg-freq (make-vector (+ max-deg 1) 0))
  (for-each (lambda (d)
              (vector-set! deg-freq d (+ (vector-ref deg-freq d) 1)))
            (vector->list deg))

  ;; 3. Calculate f[k]: number of pairs (u,v) with u<v such that deg[u]+deg[v]=k
  ;; Max possible sum of degrees is 2*(n-1).
  (define max-sum (* 2 max-deg))
  (define f (make-vector (+ max-sum 1) 0))
  (for ([d1 (in-range (+ max-deg 1))])
    (when (> (vector-ref deg-freq d1) 0)
      (for ([d2 (in-range d1 (+ max-deg 1))]) ; Iterate d2 from d1 to avoid double counting pairs (d1,d2) and (d2,d1)
        (when (> (vector-ref deg-freq d2) 0)
          (define current-sum (+ d1 d2))
          (if (= d1 d2)
              ;; If degrees are the same, count combinations C(c, 2)
              (let ([c (vector-ref deg-freq d1)])
                (vector-set! f current-sum (+ (vector-ref f current-sum) (/ (* c (- c 1)) 2))))
              ;; If degrees are different, count product c1 * c2
              (let ([c1 (vector-ref deg-freq d1)]
                    [c2 (vector-ref deg-freq d2)])
                (vector-set! f current-sum (+ (vector-ref f current-sum) (* c1 c2)))))))))

  ;; 4. Calculate ans-for-q[s]: number of pairs (u,v) with u<v such that deg[u]+deg[v] >= s
  ;; This is computed by taking suffix sums of f[k].
  (define ans-for-q (make-vector (+ max-sum 1) 0))
  (when (> (+ max-sum 1) 0)
    (vector-set! ans-for-q max-sum (vector-ref f max-sum)))
  (for ([s (in-range (- max-sum 1) -1 -1)])
    (vector-set! ans-for-q s (+ (vector-ref ans-for-q (+ s 1)) (vector-ref f s))))

  ;; 5. Calculate edge-sum-counts[s]: number of edges (u,v) such that deg[u]+deg[v]=s
  (define edge-sum-counts (make-vector (+ max-sum 1) 0))
  (for-each (lambda (edge-pair)
              (define u (vector-ref edge-pair 0))
              (define v (vector-ref edge-pair 1))
              (define current-sum (+ (vector-ref deg u) (vector-ref deg v)))
              (vector-set! edge-sum-counts current-sum (+ (vector-ref edge-sum-counts current-sum) 1)))
            (vector->list edges))

  ;; 6. Process queries
  (define result (make-vector (vector-length queries) 0))
  (for ([j (in-range (vector-length queries))])
    (define q (vector-ref queries j))
    ;; Base count is for pairs (u,v) where u<v and deg[u]+deg[v] >= q
    (define base-count (if (and (>= q 0) (<= q max-sum)) (vector-ref ans-for-q q) 0))
    ;; Adjustment for edges: if (u,v) is an edge, count(u,v) = deg[u]+deg[v]-1.
    ;; If deg[u]+deg[v] == q, then deg[u]+deg[v]-1 < q, so this pair should not be counted.
    ;; We subtract 1 for each such edge.
    (define edge-adjustment (if (and (>= q 0) (<= q max-sum)) (vector-ref edge-sum-counts q) 0))
    (vector-set! result j (- base-count edge-adjustment)))

  result)