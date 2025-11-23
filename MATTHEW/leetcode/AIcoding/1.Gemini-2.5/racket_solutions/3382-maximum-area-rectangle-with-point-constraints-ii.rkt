#lang racket
(require data/rbl-tree)

(define (maximum-area-rectangle-with-point-constraints-ii points k)
  (define n (length points))
  (when (zero? n)
    (error 'maximum-area-rectangle-with-point-constraints-ii "empty points list"))

  (define sorted-points-by-x
    (sort points (lambda (p1 p2) (< (car p1) (car p2)))))

  (define max-area 0)

  (for ([i (in-range n)])
    (define x1 (car (list-ref sorted-points-by-x i)))
    (define active-y-tree (rbl-tree))

    (for ([j (in-range i n)])
      (define p_j (list-ref sorted-points-by-x j))
      (define x2 (car p_j))
      (define y_j (cdr p_j))

      (define current-width (- x2 x1))

      ;; Add the current point's y-coordinate to the RBL tree.
      ;; The tree will contain y-coordinates of all points (px, py) such that x1 <= px <= x2.
      (set! active-y-tree (rbl-tree-add active-y-tree y_j))

      ;; If width is 0, area is 0. No need to calculate height, but tree still needs updates.
      (when (zero? current-width)
        (continue))

      (define num-active-points (rbl-tree-count active-y-tree))

      (when (zero? num-active-points)
        (continue))

      (define current-max-height 0)

      (cond
        [(<= num-active-points k)
         ;; If the number of points in the current x-range is at most k,
         ;; we can include all of them. Maximize height by taking min and max y.
         (define min-y (rbl-tree-min active-y-tree))
         (define max-y (rbl-tree-max active-y-tree))
         (set! current-max-height (- max-y min-y))]
        [else
         ;; If the number of points is greater than k, we need to find a sub-selection
         ;; of at most k points that maximizes height.
         ;; This is a sliding window problem on the sorted y-coordinates.
         ;; We iterate through all possible 'top' y-coordinates (y-top-idx)
         ;; and for each, determine the 'bottom' y-coordinate (y-bottom-idx)
         ;; such that the count of points between them is at most k.
         (for ([y-top-idx (in-range num-active-points)])
           (define y-top (rbl-tree-ref-kth active-y-tree y-top-idx))
           ;; Calculate the lowest possible index for y-bottom to ensure at most k points.
           ;; (y-top-idx - y-bottom-idx + 1) <= k  =>  y-bottom-idx >= y-top-idx - k + 1
           (define y-bottom-idx (max 0 (- y-top-idx k -1)))
           (define y-bottom (rbl-tree-ref-kth active-y-tree y-bottom-idx))
           (set! current-max-height (max current-max-height (- y-top y-bottom))))])

      (set! max-area (max max-area (* current-width current-max-height))))))

  max-area)