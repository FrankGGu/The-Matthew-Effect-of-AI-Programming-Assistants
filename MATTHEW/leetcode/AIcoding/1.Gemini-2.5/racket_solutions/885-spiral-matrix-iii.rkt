(define (spiralMatrixIII rows cols r0 c0)
  (let* ((total-points (* rows cols))
         (dirs '((0 1) (1 0) (0 -1) (-1 0)))) ; E, S, W, N direction vectors

    (define (in-bounds? r c)
      (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

    ;; The loop state represents the current position (r, c)
    ;; and the parameters for the next step.
    ;; The first point (r0, c0) is always visited and in bounds.
    (let loop ((r r0) ; current row
               (c c0) ; current column
               (dir-idx 0) ; 0:E, 1:S, 2:W, 3:N
               (current-len 1) ; current segment length (e.g., 1, 1, 2, 2, ...)
               (segment-steps-taken 0) ; steps taken in current segment
               (len-segments-completed 0) ; how many segments of current-len completed (0 or 1)
               (result (list (list r0 c0))) ; accumulated points, in reverse order
               (points-collected 1))

      (if (= points-collected total-points)
          (reverse result) ; All required points collected, reverse and return
          (let* ((current-dir-vec (list-ref dirs dir-idx))
                 (current-dr (car current-dir-vec))
                 (current-dc (cadr current-dir-vec))
                 (next-r (+ r current-dr)) ; calculate the next position
                 (next-c (+ c current-dc)))

            ;; Check if the next position is in bounds and update result/count
            (let* ((new-result (if (in-bounds? next-r next-c)
                                   (cons (list next-r next-c) result)
                                   result))
                   (new-points-collected (if (in-bounds? next-r next-c)
                                             (+ points-collected 1)
                                             points-collected))
                   (next-segment-steps-taken (+ segment-steps-taken 1)))

              (if (= next-segment-steps-taken current-len)
                  ;; Current segment completed, time to turn right
                  (let* ((next-dir-idx (modulo (+ dir-idx 1) 4)) ; Cycle directions
                         (next-len-segments-completed (+ len-segments-completed 1))
                         (next-current-len (if (= next-len-segments-completed 2)
                                               (+ current-len 1) ; Increment length after two segments
                                               current-len))
                         (next-len-segments-completed-reset (if (= next-len-segments-completed 2)
                                                                0 ; Reset count after incrementing length
                                                                next-len-segments-completed)))
                    (loop next-r next-c
                          next-dir-idx
                          next-current-len
                          0 ; Reset steps for new segment
                          next-len-segments-completed-reset
                          new-result
                          new-points-collected))
                  ;; Continue in the same direction
                  (loop next-r next-c
                        dir-idx
                        current-len
                        next-segment-steps-taken
                        len-segments-completed
                        new-result
                        new-points-collected)))))))