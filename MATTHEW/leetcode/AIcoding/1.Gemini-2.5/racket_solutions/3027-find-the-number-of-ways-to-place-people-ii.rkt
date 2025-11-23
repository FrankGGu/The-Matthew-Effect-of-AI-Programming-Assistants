(define (find-number-of-ways-to-place-people points)
  (let* ([num-points (length points)]
         ;; Remove duplicates and sort points.
         ;; Sorting order: by x-coordinate ascending, then by y-coordinate ascending.
         [sorted-points-list (sort (remove-duplicates points (lambda (p1 p2) (and (= (car p1) (car p2)) (= (cadr p1) (cadr p2)))) )
                                   (lambda (p1 p2)
                                     (let ([x1 (car p1)] [y1 (cadr p1)]
                                           [x2 (car p2)] [y2 (cadr p2)])
                                       (or (< x1 x2)
                                           (and (= x1 x2) (< y1 y2))))))]
         ;; Convert the list of points to a vector for O(1) access time.
         [sorted-points (list->vector sorted-points-list)]
         [num-unique-points (vector-length sorted-points)])

    ;; Outer loop iterates through each point p1 as a potential bottom-left corner.
    (let loop-i ([i 0] [ans 0])
      (if (>= i num-unique-points)
          ans
          (let* ([p1 (vector-ref sorted-points i)]
                 [x1 (car p1)]
                 [y1 (cadr p1)])

            ;; Inner loop iterates through points p2 to the right of p1 (or on the same x-line)
            ;; as potential top-right corners.
            ;; max-y-obstacle-right-of-x1 tracks the maximum y-coordinate of any point p_k
            ;; encountered so far (from points[i+1] to points[j-1]) such that x_k > x1 and y_k >= y1.
            (let loop-j ([j (+ i 1)] [current-ans ans] [max-y-obstacle-right-of-x1 -1])
              (if (>= j num-unique-points)
                  ;; Move to the next p1
                  (loop-i (+ i 1) current-ans)
                  (let* ([p2 (vector-ref sorted-points j)]
                         [x2 (car p2)]
                         [y2 (cadr p2)])

                    (if (< y2 y1)
                        ;; If p2's y-coordinate is less than p1's y-coordinate,
                        ;; p2 cannot be a top-right corner for p1.
                        ;; Also, such a p2 cannot be an obstacle for p1 and any future p2'
                        ;; (where p2' has y-coordinate >= y1) because p2 is below y1.
                        (loop-j (+ j 1) current-ans max-y-obstacle-right-of-x1)
                        ;; Now, y2 >= y1, so p2 is a candidate for a top-right corner.
                        (let ([is-valid-pair #t])
                          ;; Check for obstacles:
                          ;; 1. Obstacles with x-coordinate strictly greater than x1 (i.e., to the right of x1).
                          ;;    These are tracked by max-y-obstacle-right-of-x1.
                          ;;    If max-y-obstacle-right-of-x1 is within the [y1, y2] range, then p1-p2 is invalid.
                          (when (and (>= max-y-obstacle-right-of-x1 y1)
                                     (<= max-y-obstacle-right-of-x1 y2))
                            (set! is-valid-pair #f))

                          ;; 2. Vertical obstacles: points p_k on the same vertical line as p1 and p2 (i.e., x_k = x1 = x2)
                          ;;    such that y1 < y_k < y2.
                          (when (and is-valid-pair (= x2 x1))
                            ;; Due to sorting (x asc, y asc), if there's any point p_k = (x1, y_k)
                            ;; with y1 < y_k < y2, it must be at an index k such that i < k < j.
                            ;; Specifically, if j > i+1 and the point at index j-1 has x-coordinate x1,
                            ;; then it's an obstacle.
                            (when (and (> j (+ i 1)) (= (car (vector-ref sorted-points (- j 1))) x1))
                              (set! is-valid-pair #f)))

                          ;; If no obstacles were found, increment the answer.
                          (let ([new-ans (if is-valid-pair (+ current-ans 1) current-ans)])
                            ;; Update max-y-obstacle-right-of-x1 for future p2's.
                            ;; p2 itself becomes a potential obstacle for future p2's if it's to the right of x1.
                            ;; Only update if x2 > x1 (as max-y-obstacle-right-of-x1 is for points strictly right of x1).
                            (let ([new-max-y-obstacle-right-of-x1 (if (> x2 x1)
                                                                      (max max-y-obstacle-right-of-x1 y2)
                                                                      max-y-obstacle-right-of-x1)])
                              (loop-j (+ j 1) new-ans new-max-y-obstacle-right-of-x1)))))))))))