#lang racket

(define (rotate-the-box box)
  (let* ((m (vector-length box)) ; original rows
         (n (vector-length (vector-ref box 0))) ; original columns
         (rotated-rows n)
         (rotated-cols m)
         (rotated-box (make-vector rotated-rows #f)))

    ;; Initialize rotated-box with empty vectors of dots
    (for ([r (in-range rotated-rows)])
      (vector-set! rotated-box r (make-vector rotated-cols #\.)))

    ;; Step 1: Rotate 90 degrees clockwise
    ;; An element box[r_orig][c_orig] in the original matrix
    ;; moves to rotated-box[c_orig][m - 1 - r_orig] in the new matrix.
    (for ([r-orig (in-range m)])
      (for ([c-orig (in-range n)])
        (let* ((char (vector-ref (vector-ref box r-orig) c-orig))
               (r-new c-orig)
               (c-new (- m 1 r-orig)))
          (vector-set! (vector-ref rotated-box r-new) c-new char))))

    ;; Step 2: Apply gravity to the rotated-box
    (let* ((rows (vector-length rotated-box))    ; Number of rows in the rotated box
           (cols (vector-length (vector-ref rotated-box 0)))) ; Number of columns in the rotated box

      ;; Iterate through each column of the rotated-box
      (for ([c (in-range cols)])
        ;; 'next-rock-land-row' tracks the lowest available row index where a rock can land
        (let ([next-rock-land-row (- rows 1)])
          ;; Iterate from the bottom of the column upwards
          (for ([r (in-range (- rows 1) -1 -1)])
            (let ((char (vector-ref (vector-ref rotated-box r) c)))
              (cond
                ;; If an obstacle is encountered
                ((char=? char #\*)
                 ;; Rocks cannot fall past this obstacle, so reset the landing position
                 ;; to the row directly above the obstacle.
                 (set! next-rock-land-row (- r 1)))
                ;; If a rock is encountered
                ((char=? char #\#)
                 ;; Move the rock to 'next-rock-land-row' if it's not already there
                 (when (not (= r next-rock-land-row))
                   (vector-set! (vector-ref rotated-box next-rock-land-row) c #\#)
                   ;; Clear the rock's original position
                   (vector-set! (vector-ref rotated-box r) c #\.))
                 ;; Decrement 'next-rock-land-row' as this spot is now occupied
                 (set! next-rock-land-row (- next-rock-land-row 1)))
                ;; If an empty space ('.') is encountered, do nothing.
                ;; It will either be filled by a falling rock or remain empty if no rock falls into it.
                ))))))
    rotated-box))