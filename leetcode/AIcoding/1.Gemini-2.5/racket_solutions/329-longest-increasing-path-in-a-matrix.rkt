(define (longest-increasing-path matrix)
  (define rows (length matrix))
  (when (zero? rows) (error "Empty matrix"))
  (define cols (length (car matrix)))
  (when (zero? cols) (error "Empty matrix row"))

  ;; Convert matrix to vector of vectors for O(1) access
  (define matrix-vec
    (build-vector rows
                  (lambda (r)
                    (list->vector (list-ref matrix r)))))

  ;; Memoization table: vector of vectors, initialized to 0
  (define memo
    (build-vector rows
                  (lambda (r)
                    (build-vector cols (lambda (c) 0)))))

  ;; Directions for neighbors: (dr dc)
  (define directions '((0 1) (0 -1) (1 0) (-1 0)))

  ;; DFS function with memoization
  (define (dfs r c)
    ;; If already computed, return the memoized value
    (when (> (vector-ref (vector-ref memo r) c) 0)
      (vector-ref (vector-ref memo r) c))

    (let* ((current-val (vector-ref (vector-ref matrix-vec r) c))
           (max-len 1)) ; Minimum length is 1 (the cell itself)

      ;; Explore all four neighbors
      (for-each
       (lambda (dir)
         (let* ((dr (car dir))
                (dc (cadr dir))
                (nr (+ r dr))
                (nc (+ c dc)))
           ;; Check bounds and increasing path condition
           (when (and (>= nr 0) (< nr rows)
                      (>= nc 0) (< nc cols)
                      (> (vector-ref (vector-ref matrix-vec nr) nc) current-val))
             (set! max-len (max max-len (+ 1 (dfs nr nc)))))))
       directions)

      ;; Store the computed max-len in memo and return it
      (vector-set! (vector-ref memo r) c max-len)
      max-len))

  ;; Iterate through all cells to find the overall maximum path length
  (define overall-max 0)
  (for* ((r (in-range rows))
         (c (in-range cols)))
    (set! overall-max (max overall-max (dfs r c))))

  overall-max)