(define (is-stamping-possible grid stampHeight stampWidth)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  ;; 1. Compute 2D prefix sum for blocked cells
  ;; P[r][c] stores sum of grid[x][y] for 0 <= x < r, 0 <= y < c
  (define P (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

  (for* ([r (in-range m)]
         [c (in-range n)])
    (vector-set!
     (vector-ref P (+ r 1))
     (+ c 1)
     (+ (vector-ref (vector-ref grid r) c)
        (vector-ref (vector-ref P r) (+ c 1))
        (vector-ref (vector-ref P (+ r 1)) c)
        (- (vector-ref (vector-ref P r) c)))))

  ;; Helper to query sum of blocked cells in rectangle (r1, c1) to (r2, c2) inclusive (0-indexed)
  (define (query-blocked-sum r1 c1 r2 c2)
    (- (+ (vector-ref (vector-ref P (+ r2 1)) (+ c2 1))
          (vector-ref (vector-ref P r1) c1))
       (vector-ref (vector-ref P r1) (+ c2 1))
       (vector-ref (vector-ref P (+ r2 1)) c1)))

  ;; 2. Create difference array for covered cells
  ;; diff[r][c] will store the net change in stamp count at (r,c)
  ;; Size (m+1) x (n+1) to handle boundaries for r+stampHeight and c+stampWidth
  (define diff (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

  ;; Populate diff array based on possible stamp placements
  (for* ([r (in-range m)]
         [c (in-range n)])
    (when (and (<= (+ r stampHeight) m)
               (<= (+ c stampWidth) n))
      ;; Check if the current stamp area (r,c) to (r+stampHeight-1, c+stampWidth-1) is clear of blocks
      (when (= (query-blocked-sum r c (+ r stampHeight -1) (+ c stampWidth -1)) 0)
        ;; If clear, mark this stamp in the diff array
        (vector-set! (vector-ref diff r) c
                     (+ (vector-ref (vector-ref diff r) c) 1))
        (when (< (+ c stampWidth) (+ n 1)) ;; Check if c+stampWidth is within bounds of diff array (0 to n)
          (vector-set! (vector-ref diff r) (+ c stampWidth)
                       (- (vector-ref (vector-ref diff r) (+ c stampWidth)) 1)))
        (when (< (+ r stampHeight) (+ m 1)) ;; Check if r+stampHeight is within bounds of diff array (0 to m)
          (vector-set! (vector-ref diff (+ r stampHeight)) c
                       (- (vector-ref (vector-ref diff (+ r stampHeight)) c) 1)))
        (when (and (< (+ r stampHeight) (+ m 1)) (< (+ c stampWidth) (+ n 1)))
          (vector-set! (vector-ref diff (+ r stampHeight)) (+ c stampWidth)
                       (+ (vector-ref (vector-ref diff (+ r stampHeight)) (+ c stampWidth)) 1))))))

  ;; 3. Compute 2D prefix sum on diff array to get actual covered counts
  ;; covered-count[r][c] stores the number of stamps covering cell (r,c)
  (define covered-count (make-vector m (lambda () (make-vector n 0))))

  (for* ([r (in-range m)]
         [c (in-range n)])
    (define current-val (vector-ref (vector-ref diff r) c))
    (when (> r 0)
      (set! current-val (+ current-val (vector-ref (vector-ref covered-count (- r 1)) c))))
    (when (> c 0)
      (set! current-val (+ current-val (vector-ref (vector-ref covered-count r) (- c 1)))))
    (when (and (> r 0) (> c 0))
      (set! current-val (- current-val (vector-ref (vector-ref covered-count (- r 1)) (- c 1)))))
    (vector-set! (vector-ref covered-count r) c current-val))

  ;; 4. Final check: ensure all empty cells are covered
  (define all-covered? #t)
  (for* ([r (in-range m)]
         [c (in-range n)]
         #:when all-covered?) ; Short-circuit the loop if an uncovered empty cell is found
    (when (and (= (vector-ref (vector-ref grid r) c) 0) ;; If it's an empty cell
               (= (vector-ref (vector-ref covered-count r) c) 0)) ;; And it's not covered
      (set! all-covered? #f)))
  all-covered?)