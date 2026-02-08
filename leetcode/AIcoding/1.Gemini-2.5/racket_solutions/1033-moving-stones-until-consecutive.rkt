(define (num-moves-stones a b c)
  (let* ((sorted-stones (sort (list a b c) <))
         (x (car sorted-stones))
         (y (cadr sorted-stones))
         (z (caddr sorted-stones)))

    (let ((min-moves
           (cond
             ((= (- z x) 2) 0) ; Stones are already consecutive (x, x+1, x+2)
             ((and (> (- y x) 2) (> (- z y) 2)) 2) ; Both gaps are greater than 2
             (else 1))) ; One gap is 1 or 2, and not already consecutive

          (max-moves
           (- z x 2))) ; Total empty spaces between x and z, excluding y's spot

      (list min-moves max-moves))))