#lang racket

(require data/queue)

(define (has-valid-path grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define (valid-coords r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  ; Directions: 0: Up, 1: Down, 2: Left, 3: Right
  (define dr '(-1 1 0 0)) ; Change in row for each direction
  (define dc '(0 0 -1 1)) ; Change in column for each direction

  ; For each street type (1-6), list of directions it connects to.
  ; Index 0 is a dummy value to align with 1-based street types.
  (define street-connections
    (list
     #f          ; Dummy for index 0
     '(2 3)      ; Street 1: Left, Right
     '(0 1)      ; Street 2: Up, Down
     '(1 2)      ; Street 3: Down, Left
     '(1 3)      ; Street 4: Down, Right
     '(0 2)      ; Street 5: Up, Left
     '(0 3)      ; Street 6: Up, Right
     ))

  ; Opposite direction mapping:
  ; 0 (Up) -> 1 (Down)
  ; 1 (Down) -> 0 (Up)
  ; 2 (Left) -> 3 (Right)
  ; 3 (Right) -> 2 (Left)
  (define opposite-dir '(1 0 3 2))

  ; Initialize BFS queue and visited set
  (define q (make-queue))
  (define visited (make-hash))

  ; Start BFS from (0,0)
  (queue-add! q (list 0 0))
  (hash-set! visited (list 0 0) #t)

  ; BFS recursive loop
  (let bfs-recursive ()
    (if (queue-empty? q)
        #f ; Queue is empty, no path found
        (let* ((curr (queue-remove! q))
               (r (car curr))
               (c (cadr curr)))

          ; Check if target (m-1, n-1) is reached
          (if (and (= r (- m 1)) (= c (- n 1)))
              #t ; Path found
              (begin
                (let ((current-street-type (list-ref (list-ref grid r) c)))
                  ; Explore all 4 possible directions
                  (for-each
                   (lambda (dir-idx)
                     (let* ((nr (+ r (list-ref dr dir-idx)))
                            (nc (+ c (list-ref dc dir-idx))))
                       ; Check if next coordinates are within grid boundaries
                       (when (valid-coords nr nc)
                         (let ((next-street-type (list-ref (list-ref grid nr) nc)))
                           ; Check if current street allows exit in this direction
                           (when (member dir-idx (list-ref street-connections current-street-type))
                             ; Check if next street allows entry from the opposite direction
                             (when (member (list-ref opposite-dir dir-idx) (list-ref street-connections next-street-type))
                               (let ((next-pos (list nr nc)))
                                 ; If not visited, add to queue and mark as visited
                                 (when (not (hash-has-key? visited next-pos))
                                   (hash-set! visited next-pos #t)
                                   (queue-add! q next-pos))))))))))
                   '(0 1 2 3)))
                (bfs-recursive))))))) ; Continue BFS