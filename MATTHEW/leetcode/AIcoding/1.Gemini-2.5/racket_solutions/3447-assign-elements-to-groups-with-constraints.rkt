#lang racket

(define MOD 1000000007)

(define (make-dsu n)
  (define parent (build-vector n (lambda (i) i)))
  (define fixed-group (build-vector n (lambda (i) -1))) ; -1 means no fixed group
  (define forbidden-groups (build-vector n (lambda (i) (make-hash)))) ; hash set for forbidden groups
  (list parent fixed-group forbidden-groups))

(define (dsu-find dsu i)
  (define parent (car dsu))
  (let loop ((curr i))
    (let ((p (vector-ref parent curr)))
      (if (= p curr)
          curr
          (let ((root (loop p)))
            (vector-set! parent curr root)
            root)))))

(define (dsu-union dsu i j)
  (define parent (car dsu))
  (define fixed-group (cadr dsu))
  (define forbidden-groups (caddr dsu))

  (let ((root-i (dsu-find dsu i))
        (root-j (dsu-find dsu j)))
    (cond
      ((= root-i root-j) #t) ; Already in the same set
      (else
       ;; Merge root-j into root-i (arbitrary choice, could optimize by size/rank)
       (vector-set! parent root-j root-i)

       ;; Combine fixed groups
       (let ((fg-i (vector-ref fixed-group root-i))
             (fg-j (vector-ref fixed-group root-j)))
         (cond
           ((and (not (= fg-i -1)) (not (= fg-j -1)) (not (= fg-i fg-j)))
            #f) ; Contradiction: both fixed to different groups
           ((not (= fg-j -1))
            (vector-set! fixed-group root-i fg-j))))

       ;; Combine forbidden groups
       (let ((fgs-i (vector-ref forbidden-groups root-i))
             (fgs-j (vector-ref forbidden-groups root-j)))
         (hash-for-each (lambda (g v) (hash-set! fgs-i g #t)) fgs-j))

       ;; Check for contradiction after merge
       (let ((fg-new (vector-ref fixed-group root-i))
             (fgs-new (vector-ref forbidden-groups root-i)))
         (if (and (not (= fg-new -1)) (hash-has-key? fgs-new fg-new))
             #f ; Contradiction: fixed group is also forbidden
             #t)))))) ; Success

(define (count-ways-for-component nodes-C adj-C fixed-map-C forbidden-map-C k)
  (define m (vector-length nodes-C))
  (when (= m 0) (error "Empty component")) ; Should not happen with non-empty nodes-C

  ;; Evaluate P(G, j) for j = 0 to m
  ;; P(G, j) is the number of ways to color the component graph C using j colors
  ;; We will use a backtracking function for this.
  (define (solve-for-j current-j)
    (define memo (make-hash)) ; Memoization table for (idx, assignment-vector)

    (define (backtrack idx assignment-vec)
      (cond
        ((= idx m) 1) ; All nodes assigned, one valid way
        (else
         (let ((memo-key (list->immutable-vector assignment-vec)))
           (let ((cached (hash-ref memo memo-key #f)))
             (if cached
                 cached
                 (let* ((node (vector-ref nodes-C idx))
                        (fixed-g (hash-ref fixed-map-C node -1))
                        (forbidden-set (hash-ref forbidden-map-C node (make-hash)))
                        (count 0))
                   (for ((color (in-range current-j)))
                     (let ((valid? #t))
                       ;; Check fixed group constraint
                       (when (and (not (= fixed-g -1)) (not (= fixed-g color)))
                         (set! valid? #f))
                       ;; Check forbidden group constraint
                       (when (hash-has-key? forbidden-set color)
                         (set! valid? #f))
                       ;; Check adjacency constraint
                       (when valid?
                         (for ((neighbor-root (in-list (hash-ref adj-C node '()))))
                           (let loop-nodes ((n-idx 0))
                             (when (< n-idx idx) ; Only check already assigned neighbors
                               (when (= (vector-ref nodes-C n-idx) neighbor-root)
                                 (when (= (vector-ref assignment-vec n-idx) color)
                                   (set! valid? #f)))
                               (loop-nodes (+ n-idx 1))))))

                       (when valid?
                         (vector-set! assignment-vec idx color)
                         (set! count (modulo (+ count (backtrack (+ idx 1) assignment-vec)) MOD))
                         (vector-set! assignment-vec idx -1) ; Backtrack: reset color
                         )))
                   (hash-set! memo memo-key count)
                   count)))))))

    (backtrack 0 (build-vector m (lambda (i) -1)))) ; Initial assignment vector with -1s

  ;; Compute P(G, j) for j = 0 to m
  (define P-values (build-vector (+ m 1) solve-for-j))

  ;; Calculate coefficients c_i for P(G, k) = sum_{i=0}^m c_i * k_fall_i
  ;; where k_fall_i = k * (k-1) * ... * (k-i+1)
  ;; P(G, j) = sum_{i=0}^j c_i * j_fall_i
  ;; This is a system of linear equations. Can be solved iteratively.
  ;; c_0 = P(G, 0)
  ;; c_1 = P(G, 1) - c_0 * 1_fall_0
  ;; c_2 = (P(G, 2) - c_0 * 2_fall_0 - c_1 * 2_fall_1) / 2_fall_2
  ;; In general: c_j = (P(G, j) - sum_{i=0}^{j-1} c_i * j_fall_i) / j_fall_j
  (define c-coeffs (build-vector (+ m 1) (lambda (i) 0)))

  (for ((j (in-range (+ m 1))))
    (let ((current-sum 0))
      (for ((i (in-range j)))
        (let loop-fall ((val j) (count i) (res 1))
          (if (= count 0)
              (set! current-sum (modulo (+ current-sum (modulo (* (vector-ref c-coeffs i) res) MOD)) MOD))
              (loop-fall (- val 1) (- count 1) (modulo (* res val) MOD)))))

      (let ((j-fall-j (let loop-fall ((val j) (count j) (res 1))
                        (if (= count 0)
                            res
                            (loop-fall (- val 1) (- count 1) (modulo (* res val) MOD))))))
        (when (= j-fall-j 0) ; If j_fall_j is 0, it implies P(G, j) must be 0 for consistency
          (when (not (= (vector-ref P-values j) 0)) (error "Contradiction in chromatic polynomial"))
          (vector-set! c-coeffs j 0)) ; This coefficient doesn't contribute
        (unless (= j-fall-j 0)
          (let* ((val-P (vector-ref P-values j))
                 (term-numerator (modulo (- val-P current-sum) MOD))
                 (inv-j-fall-j (power j-fall-j (- MOD 2)))) ; Modular inverse
            (vector-set! c-coeffs j (modulo (* term-numerator inv-j-fall-j) MOD)))))))

  ;; Evaluate P(G, k) with actual k
  (let ((total-ways 0))
    (for ((i (in-range (+ m 1))))
      (let loop-fall ((val k) (count i) (res 1))
        (if (= count 0)
            (set! total-ways (modulo (+ total-ways (modulo (* (vector-ref c-coeffs i) res) MOD)) MOD))
            (loop-fall (- val 1) (- count 1) (modulo (* res val) MOD)))))
    total-ways))

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (if (= e 0)
        res
        (let ((new-b (modulo (* b b) MOD))
              (new-e (quotient e 2)))
          (if (odd? e)
              (loop new-b new-e (modulo (* res b) MOD))
              (loop new-b new-e res))))))

(define (assign-elements-to-groups-with-constraints n k constraints)
  (define dsu (make-dsu n))
  (define parent (car dsu))
  (define fixed-group (cadr dsu))
  (define forbidden-groups (caddr dsu))

  ;; Step 1: Process Type 2 and Type 3 constraints
  (for ((constraint (in-list constraints)))
    (match constraint
      ((list 2 u val)
       (let ((root-u (dsu-find dsu u)))
         (let ((fg-u (vector-ref fixed-group root-u))
               (fgs-u (vector-ref forbidden-groups root-u)))
           (cond
             ((and (not (= fg-u -1)) (not (= fg-u val))) (pure-return 0)) ; Contradiction
             ((hash-has-key? fgs-u val) (pure-return 0)) ; Contradiction
             (else
              (vector-set! fixed-group root-u val))))))
      ((list 3 u val)
       (let ((root-u (dsu-find dsu u)))
         (let ((fg-u (vector-ref fixed-group root-u))
               (fgs-u (vector-ref forbidden-groups root-u)))
           (cond
             ((= fg-u val) (pure-return 0)) ; Contradiction
             (else
              (hash-set! fgs-u val #t))))))
      (_ #f))) ; Ignore other types for now

  ;; Step 2: Process Type 0 constraints using DSU
  (for ((constraint (in-list constraints)))
    (match constraint
      ((list 0 u v)
       (unless (dsu-union dsu u v) (pure-return 0))) ; Contradiction during union
      (_ #f)))

  ;; After all DSU operations, consolidate fixed/forbidden groups for roots
  ;; This is needed because fixed-group and forbidden-groups are updated only on the new root during union.
  ;; We need to propagate fixed/forbidden status from all elements to their root.
  ;; This is implicitly handled by the dsu-union logic where fixed and forbidden groups are merged to the new root.
  ;; However, if an element was fixed/forbidden *before* its root was, and then that root changes,
  ;; the fixed/forbidden status needs to be checked again for the new root.
  ;; A simpler way is to re-evaluate for all roots after all DSU operations.
  (define root-fixed-group (build-vector n (lambda (i) -1)))
  (define root-forbidden-groups (build-vector n (lambda (i) (make-hash))))

  (for ((i (in-range n)))
    (let ((root (dsu-find dsu i)))
      ;; Update fixed group for the root
      (let ((fg-i (vector-ref fixed-group i))
            (fg-root (vector-ref root-fixed-group root)))
        (cond
          ((and (not (= fg-i -1)) (not (= fg-root -1)) (not (= fg-i fg-root))) (pure-return 0)) ; Contradiction
          ((not (= fg-i -1)) (vector-set! root-fixed-group root fg-i))))

      ;; Update forbidden groups for the root
      (let ((fgs-i (vector-ref forbidden-groups i))
            (fgs-root (vector-ref root-forbidden-groups root)))
        (hash-for-each (lambda (g v) (hash-set! fgs-root g #t)) fgs-i))))

  ;; Final check for contradictions based on consolidated root properties
  (for ((i (in-range n)))
    (when (= (vector-ref parent i) i) ; If i is a root
      (let ((fg-root (vector-ref root-fixed-group i))
            (fgs-root (vector-ref root-forbidden-groups i)))
        (when (and (not (= fg-root -1)) (hash-has-key? fgs-root fg-root))
          (pure-return 0)) ; Contradiction: fixed group is also forbidden
        (when (and (= fg-root -1) (= (hash-count fgs-root) k))
          (pure-return 0)) ; Contradiction: no possible group left for unfixed root
        )))

  ;; Step 3: Build the component graph for Type 1 constraints
  (define component-roots (make-vector 0)) ; List of actual roots
  (define root-to-idx (make-hash)) ; Map root value to its index in component-roots vector
  (define idx-counter 0)
  (for ((i (in-range n)))
    (when (= (vector-ref parent i) i)
      (set! component-roots (vector-append component-roots (vector i)))
      (hash-set! root-to-idx i idx-counter)
      (set! idx-counter (+ idx-counter 1))))

  (define num-components (vector-length component-roots))
  (define component-adj (make-hash)) ; Adjacency list for component graph (root -> list of roots)
  (define visited-component-root (build-vector num-components (lambda (i) #f)))

  (for ((constraint (in-list constraints)))
    (match constraint
      ((list 1 u v)
       (let ((root-u (dsu-find dsu u))
             (root-v (dsu-find dsu v)))
         (when (= root-u root-v) (pure-return 0)) ; Contradiction: same component but must be different
         (hash-set! component-adj root-u (cons root-v (hash-ref component-adj root-u '())))
         (hash-set! component-adj root-v (cons root-u (hash-ref component-adj root-v '())))))
      (_ #f)))

  ;; Step 4: Count ways by iterating connected components of the component graph
  (define total-ways 1)

  (for ((i (in-range num-components)))
    (unless (vector-ref visited-component-root i)
      (let ((current-component-nodes (make-vector 0))
            (q (make-queue)))
        (queue-add! q (vector-ref component-roots i))
        (vector-set! visited-component-root i #t)

        (let loop-bfs ()
          (unless (queue-empty? q)
            (let ((curr-root (queue-remove! q)))
              (set! current-component-nodes (vector-append current-component-nodes (vector curr-root)))
              (for ((neighbor-root (in-list (hash-ref component-adj curr-root '()))))
                (let ((neighbor-idx (hash-ref root-to-idx neighbor-root)))
                  (unless (vector-ref visited-component-root neighbor-idx)
                    (vector-set! visited-component-root neighbor-idx #t)
                    (queue-add! q neighbor-root)))))
            (loop-bfs)))

        ;; Calculate ways for this connected component
        (set! total-ways (modulo (* total-ways 
                                   (count-ways-for-component 
                                    current-component-nodes 
                                    component-adj 
                                    root-fixed-group 
                                    root-forbidden-groups 
                                    k)) 
                                 MOD))))
  total-ways)

(provide (all-defined-out))