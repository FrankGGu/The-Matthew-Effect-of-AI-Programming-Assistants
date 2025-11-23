(require srfi/1)

(define (whac-a-mole moles)
  (let* ((n (length moles))
         ;; Sort moles by their appearance time
         (sorted-moles (sort moles (lambda (m1 m2) (< (list-ref m1 2) (list-ref m2 2)))))
         ;; dp[i] stores the maximum number of moles hit if sorted-moles[i] is the last mole hit
         (dp (make-vector n 0)))

    ;; Helper function to calculate Manhattan distance between two mole positions
    (define (manhattan-distance p1 p2)
      (+ (abs (- (list-ref p1 0) (list-ref p2 0)))
         (abs (- (list-ref p1 1) (list-ref p2 1)))))

    (let loop ((i 0) (max-moles 0))
      (when (< i n)
        (let* ((current-mole (list-ref sorted-moles i))
               (cx (list-ref current-mole 0))
               (cy (list-ref current-mole 1))
               (ct (list-ref current-mole 2)))

          ;; Case 1: Hit current-mole directly from the starting point (0,0) at time 0
          (let ((time-from-start (+ (abs cx) (abs cy))))
            (when (<= time-from-start ct)
              (vector-set! dp i 1)))

          ;; Case 2: Hit current-mole after hitting a previous mole j
          (let loop-j ((j 0))
            (when (< j i)
              (let* ((prev-mole (list-ref sorted-moles j))
                     (prev-time (list-ref prev-mole 2)))
                ;; Only consider previous moles that could actually be hit
                (when (> (vector-ref dp j) 0)
                  (let ((travel-time (manhattan-distance prev-mole current-mole)))
                    ;; Check if there's enough time to travel from prev-mole to current-mole
                    (when (<= (+ prev-time travel-time) ct)
                      (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1)))))))
              (loop-j (+ j 1))))

          ;; Update the overall maximum moles hit
          (set! max-moles (max max-moles (vector-ref dp i)))
        )
        (loop (+ i 1) max-moles)
      )
      max-moles)))