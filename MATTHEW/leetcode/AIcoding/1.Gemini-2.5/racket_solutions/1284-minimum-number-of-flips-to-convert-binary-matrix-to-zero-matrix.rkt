#lang racket

(require data/queue)
(require racket/hash)

(define (min-flips matrix)
  (define m (length matrix))
  (define n (length (car matrix)))

  ;; Helper to check if a matrix is all zeros
  (define (is-zero-matrix? mat)
    (andmap (lambda (row) (andmap (lambda (cell) (= cell 0)) row)) mat))

  ;; Helper to create a new matrix by flipping a cell and its neighbors
  (define (flip-at mat r c)
    ;; Deep copy the matrix
    (define new-mat (build-list m (lambda (i) (build-list n (lambda (j) (list-ref (list-ref mat i) j))))))
    (define (toggle val) (if (= val 0) 1 0))

    ;; Helper to safely toggle a cell at (r_idx, c_idx) within matrix bounds
    (define (safe-toggle r_idx c_idx)
      (when (and (>= r_idx 0) (< r_idx m) (>= c_idx 0) (< c_idx n))
        ;; Modify the specific cell in the copied matrix
        (list-set! (list-ref new-mat r_idx) c_idx (toggle (list-ref (list-ref new-mat r_idx) c_idx)))))

    (safe-toggle r c)         ; Flip current cell
    (safe-toggle (- r 1) c)   ; Up
    (safe-toggle (+ r 1) c)   ; Down
    (safe-toggle r (- c 1))   ; Left
    (safe-toggle r (+ c 1))   ; Right
    new-mat)

  ;; Queue for BFS: stores (list matrix flip-count)
  (define q (make-queue))
  (queue-add! q (list matrix 0))

  ;; Set for visited matrices (using a hash-set with equal? for deep comparison)
  (define visited (make-hash-set))
  (hash-set-add! visited matrix)

  ;; Main BFS loop
  (let bfs-loop ()
    (if (queue-empty? q)
        -1 ; No solution found
        (let* ([current-state (queue-remove! q)]
               [current-matrix (car current-state)]
               [current-flips (cadr current-state)])

          (if (is-zero-matrix? current-matrix)
              current-flips ; Found solution, return the flip count
              (begin
                ;; Explore all possible next states by flipping each cell
                (for* ([r (in-range m)]
                       [c (in-range n)])
                  (let* ([next-matrix (flip-at current-matrix r c)])
                    ;; If this matrix state has not been visited, add it to queue and visited set
                    (unless (hash-set-contains? visited next-matrix)
                      (hash-set-add! visited next-matrix)
                      (queue-add! q (list next-matrix (+ current-flips 1))))))
                (bfs-loop)))))) ; Continue BFS
  )