(define (projection-area grid)
  (let* ((n (length grid))
         (grid-transposed (apply map list grid)))

    (let ((xy-plane-area
           (apply + (map (lambda (row)
                           (apply + (map (lambda (h) (if (> h 0) 1 0)) row)))
                         grid)))

          (xz-plane-area
           (apply + (map (lambda (row) (apply max 0 row)) grid)))

          (yz-plane-area
           (apply + (map (lambda (col) (apply max 0 col)) grid-transposed))))

      (+ xy-plane-area xz-plane-area yz-plane-area))))