#lang racket
(require data/heap)
(require math/flonum) ; For +inf.0

(define (minimum-time-to-visit-a-cell-in-a-grid grid)
  (call/cc
   (lambda (return-from-solve)
     (define m (length grid))
     (define n (length (car grid)))

     ;; Specific edge case handling for impossibility:
     ;; If grid[0][1] > 1 and grid[1][0] > 1, it's impossible to make the first move.
     ;; You start at (0,0) at time 0. To move to (0,1), you would arrive at time 1.
     ;; But you can only visit (0,1) at time 1 if grid[0][1] <= 1.
     ;; If grid[0][1] > 1, you cannot visit it at time 1.
     ;; Similarly for (1,0).
     ;; If both adjacent cells require a time > 1, you cannot make any initial move,
     ;; effectively trapping you at (0,0).
     (when (and (> (list-ref (list-ref grid 0) 1) 1)
                (> (list-ref (list-ref grid 1) 0) 1))
       (return-from-solve -1))

     ;; Initialize distance array with infinity
     (define dist (build-vector m (lambda (i) (build-vector n (lambda (j) +inf.0)))))
     ;; Starting cell (0,0) has time 0
     (vector-set! (vector-ref dist 0) 0 0)

     ;; Priority queue stores (time r c), ordered by time
     (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
     (heap-add! pq '(0 0 0)) ; (time row col)

     ;; Directions for neighbors
     (define dr '(-1 1 0 0))
     (define dc '(0 0 -1 1))

     (let loop ()
       (when (not (heap-empty? pq))
         (define current-item (heap-min pq))
         (heap-remove-min! pq)

         (define current-time (car current-item))
         (define r (cadr current-item))
         (define c (caddr current-item))

         ;; If we've already found a shorter path to this cell, skip.
         (when (> current-time (vector-ref (vector-ref dist r) c))
           (loop))

         ;; If we reached the target cell (m-1, n-1), return its time.
         (when (and (= r (- m 1)) (= c (- n 1)))
           (return-from-solve current-time))

         ;; Explore neighbors
         (for ([i (in-range 4)])
           (define nr (+ r (list-ref dr i)))
           (define nc (+ c (list-ref dc i)))

           ;; Check if neighbor is within grid bounds
           (when (and (>= nr 0) (< nr m) (>= nc 0) (< nc n))
             (define target-cell-value (list-ref (list-ref grid nr) nc))
             (define new-time 0)

             ;; Calculate the earliest time we could arrive at (nr, nc) if we move immediately
             (define arrival-if-move-now (+ current-time 1))

             (if (<= target-cell-value arrival-if-move-now)
                 ;; Case 1: The target cell's value allows immediate arrival.
                 ;; New time is simply current_time + 1.
                 (set! new-time arrival-if-move-now)
                 ;; Case 2: The target cell's value is too high for immediate arrival (target_cell_value > current_time + 1).
                 ;; We must wait until at least target_cell_value to enter (nr, nc).
                 ;; Also, the arrival time must have the same parity as arrival_if_move_now (since it's a 1-step move).
                 (begin
                   ;; Candidate arrival time is target_cell_value.
                   ;; This is effectively `max(arrival_if_move_now, target_cell_value)`
                   ;; but since we are in the `else` branch, `target_cell_value` is already greater.
                   (define candidate-arrival-time target-cell-value)

                   ;; Check parity: if (candidate-arrival-time - arrival-if-move-now) is odd,
                   ;; they have different parities. We need to wait one extra second.
                   (if (= (modulo (- candidate-arrival-time arrival-if-move-now) 2) 0)
                       ;; Same parity, no extra wait needed.
                       (set! new-time candidate-arrival-time)
                       ;; Different parity, wait one extra second to match parity.
                       (set! new-time (+ candidate-arrival-time 1)))))

             ;; If this new time is better than the previously recorded time for (nr, nc), update and add to PQ.
             (when (< new-time (vector-ref (vector-ref dist nr) nc))
               (vector-set! (vector-ref dist nr) nc new-time)
               (heap-add! pq (list new-time nr nc))))))
       (loop)) ; Continue the loop

     ;; If the loop finishes and the target cell was not reached (i.e., its distance is still infinity),
     ;; it means it's impossible. This case should be covered by the initial check,
     ;; but as a fallback, we check the final distance.
     (define final-dist (vector-ref (vector-ref dist (- m 1)) (- n 1)))
     (if (= final-dist +inf.0)
         -1
         final-dist))))