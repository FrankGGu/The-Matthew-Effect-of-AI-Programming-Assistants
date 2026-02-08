(define (count-fertile-pyramids grid-list)
  ;; Convert List[List[int]] to Vector[Vector[int]] for O(1) access
  (define m (length grid-list))
  (define n (length (car grid-list))) ; Assuming non-empty grid and all rows have same length

  (define grid (make-vector m))
  (for ([r (in-range m)])
    (vector-set! grid r (list->vector (list-ref grid-list r))))

  ;; dp-down[r][c] stores the maximum height of a fertile pyramid
  ;; with its top at (r, c) extending downwards.
  (define dp-down (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dp-down i (make-vector n 0)))

  ;; dp-up[r][c] stores the maximum height of an inverse fertile pyramid
  ;; with its top at (r, c) extending upwards.
  (define dp-up (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dp-up i (make-vector n 0)))

  ;; Calculate dp-down
  ;; Iterate r from m-1 down to 0
  (for ([r (in-range (- m 1) -1 -1)])
    ;; Iterate c from 0 to n-1
    (for ([c (in-range n)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (if (or (= r (- m 1)) (= c 0) (= c (- n 1)))
            ;; Base case: height 1 if at last row or column boundary
            (vector-set! (vector-ref dp-down r) c 1)
            ;; Recursive step: 1 + min of heights of three cells below
            (let* ([val-diag-left (vector-ref (vector-ref dp-down (+ r 1)) (- c 1))]
                   [val-center (vector-ref (vector-ref dp-down (+ r 1)) c)]
                   [val-diag-right (vector-ref (vector-ref dp-down (+ r 1)) (+ c 1))])
              (vector-set! (vector-ref dp-down r) c
                           (+ 1 (min val-diag-left val-center val-diag-right))))))))

  ;; Calculate dp-up
  ;; Iterate r from 0 up to m-1
  (for ([r (in-range m)])
    ;; Iterate c from 0 to n-1
    (for ([c (in-range n)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (if (or (= r 0) (= c 0) (= c (- n 1)))
            ;; Base case: height 1 if at first row or column boundary
            (vector-set! (vector-ref dp-up r) c 1)
            ;; Recursive step: 1 + min of heights of three cells above
            (let* ([val-diag-left (vector-ref (vector-ref dp-up (- r 1)) (- c 1))]
                   [val-center (vector-ref (vector-ref dp-up (- r 1)) c)]
                   [val-diag-right (vector-ref (vector-ref dp-up (- r 1)) (+ c 1))])
              (vector-set! (vector-ref dp-up r) c
                           (+ 1 (min val-diag-left val-center val-diag-right))))))))

  ;; Sum up the counts
  ;; A pyramid of height H contributes H-1 to the total count (excluding height 1 pyramids)
  (define total-pyramids 0)
  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (set! total-pyramids (+ total-pyramids (max 0 (- (vector-ref (vector-ref dp-down r) c) 1))))
      (set! total-pyramids (+ total-pyramids (max 0 (- (vector-ref (vector-ref dp-up r) c) 1))))))

  total-pyramids)