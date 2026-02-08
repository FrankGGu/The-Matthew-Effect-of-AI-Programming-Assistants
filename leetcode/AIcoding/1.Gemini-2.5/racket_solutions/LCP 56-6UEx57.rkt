#lang racket

(define (make-queue)
  (let ((front (box '()))
        (back (box '())))
    ;; The front box points to the first actual element.
    ;; The back box points to the last cons cell.
    ;; Initially, front points to a dummy cell, and back points to that dummy cell.
    (set-box! front back)
    (list front back)))

(define (queue-empty? q)
  ;; The queue is empty if the front box points to the same cons cell
  ;; as the back box, meaning there are no elements between them.
  (eq? (unbox (car q)) (cdr (unbox (cdr q)))))

(define (queue-enqueue! q item)
  (let ((new-cell (cons item '())))
    ;; Update the cdr of the current last cell to point to the new cell.
    (set-cdr! (unbox (cdr q)) new-cell)
    ;; Update the back box to point to the new cell (which is now the last cell).
    (set-box! (cdr q) new-cell)))

(define (queue-dequeue! q)
  (let ((front-box (car q)))
    (when (queue-empty? q)
      (error 'queue-dequeue! "Queue is empty"))
    ;; Move the front box to point to the next element.
    (set-box! front-box (cdr (unbox front-box)))
    ;; Return the value of the element that was just dequeued.
    (car (unbox front-box))))

(define (relic-transfer grid start end)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define start-r (list-ref start 0))
  (define start-c (list-ref start 1))
  (define end-r (list-ref end 0))
  (define end-c (list-ref end 1))

  ;; Helper to check if a position (r, c) is within grid boundaries.
  (define (valid-grid-pos r c)
    (and (>= r 0) (< r rows)
         (>= c 0) (< c cols)))

  ;; Handle initial edge cases
  (cond
    ;; If start or end positions are out of bounds.
    ((or (not (valid-grid-pos start-r start-c))
         (not (valid-grid-pos end-r end-c)))
     -1)

    ;; If start or end positions are obstacles (assuming 1 is obstacle, 0 is walkable).
    ((or (= (list-ref (list-ref grid start-r) start-c) 1)
         (= (list-ref (list-ref grid end-r) end-c) 1))
     -1)

    ;; If start and end are the same and walkable, 0 steps are needed.
    ((and (= start-r end-r) (= start-c end-c))
     0)

    ;; Otherwise, proceed with Breadth-First Search (BFS).
    (else
     (define q (make-queue))           ; Queue for BFS states (r c steps)
     (define visited (make-hash))      ; Hash table to keep track of visited cells

     ;; Directions for 4-way movement (up, down, left, right)
     (define dr (list -1 1 0 0))
     (define dc (list 0 0 -1 1))

     ;; Helper to convert (r, c) coordinates to a unique integer key for the hash table.
     (define (pos->key r c)
       (+ (* r cols) c))

     ;; Enqueue the starting position with 0 steps.
     (queue-enqueue! q (list start-r start-c 0))
     ;; Mark the starting position as visited.
     (hash-set! visited (pos->key start-r start-c) #t)

     ;; BFS loop
     (let bfs-loop ()
       (if (queue-empty? q)
           -1 ; If the queue is empty and we haven't reached the end, no path exists.
           (let* ((current-state (queue-dequeue! q)) ; Get the current state (r c steps)
                  (r (list-ref current-state 0))
                  (c (list-ref current-state 1))
                  (steps (list-ref current-state 2)))

             ;; If the current position is the target end position, return the steps.
             (when (and (= r end-r) (= c end-c))
               (steps)) ; This returns 'steps' and exits the 'bfs-loop'

             ;; Explore all 4 neighbors (up, down, left, right).
             (for ([i (range 4)])
               (define nr (+ r (list-ref dr i)))
               (define nc (+ c (list-ref dc i)))

               ;; Check if the neighbor is valid, not an obstacle, and not yet visited.
               (when (and (valid-grid-pos nr nc)
                          (= (list-ref (list-ref grid nr) nc) 0) ; 0 is walkable
                          (not (hash-has-key? visited (pos->key nr nc))))
                 ;; Mark the neighbor as visited.
                 (hash-set! visited (pos->key nr nc) #t)
                 ;; Enqueue the neighbor with an incremented step count.
                 (queue-enqueue! q (list nr nc (+ steps 1)))))
             ;; Continue the BFS loop.
             (bfs-loop))))))