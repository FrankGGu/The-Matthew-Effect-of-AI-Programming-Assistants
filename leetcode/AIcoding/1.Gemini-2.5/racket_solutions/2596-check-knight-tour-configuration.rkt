(define (check-knight-tour-configuration grid)
  (let* ((n (length grid))
         (total-cells (* n n)))

    ;; Helper to find coordinates of a target value
    (define (find-coords target)
      (for*/first ((r (range n))
                   (c (range n)))
        (when (= (list-ref (list-ref grid r) c) target)
          (list r c))))

    ;; Helper to check if (r2, c2) is a valid knight's move from (r1, c1)
    (define (is-knight-move r1 c1 r2 c2)
      (let ((dr (abs (- r1 r2)))
            (dc (abs (- c1 c2))))
        (or (and (= dr 1) (= dc 2))
            (and (= dr 2) (= dc 1)))))

    ;; 1. Check if the starting position (0, 0) contains 0
    (unless (= (list-ref (list-ref grid 0) 0) 0)
      (error 'check-knight-tour-configuration "Starting position must be 0")) ; This should be #f for LeetCode

    ;; Corrected starting position check
    (unless (= (list-ref (list-ref grid 0) 0) 0)
      #f)

    ;; 2. Iterate from k = 0 to n*n - 2 and check if the next move (k+1) is valid
    (for/and ((k (range (- total-cells 1)))) ; k goes from 0 to total-cells - 2
      (let* ((current-coords (find-coords k))
             (next-coords (find-coords (+ k 1)))
             (r1 (list-ref current-coords 0))
             (c1 (list-ref current-coords 1))
             (r2 (list-ref next-coords 0))
             (c2 (list-ref next-coords 1)))
        (is-knight-move r1 c1 r2 c2)))
    ))