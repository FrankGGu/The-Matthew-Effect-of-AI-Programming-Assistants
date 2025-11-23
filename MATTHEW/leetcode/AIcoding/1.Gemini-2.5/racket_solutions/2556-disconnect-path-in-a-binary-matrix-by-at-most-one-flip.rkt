#lang racket
(require racket/queue)

(define (disconnect-path grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  ;; Helper function to check if (end-r, end-c) is reachable from (start-r, start-c)
  ;; in the given grid using BFS.
  (define (can-reach current-grid current-m current-n start-r start-c end-r end-c)
    ;; If start or end cell is 0, no path exists.
    (if (or (= (vector-ref (vector-ref current-grid start-r) start-c) 0)
            (= (vector-ref (vector-ref current-grid end-r) end-c) 0))
        #f
        (let* ([q (make-queue)]
               [visited (make-vector current-m (lambda () (make-vector current-n #f)))])

          (queue-add! q (list start-r start-c))
          (vector-set! (vector-ref visited start-r) start-c #t)

          (let loop ()
            (if (queue-empty? q)
                #f ; No path found
                (let* ([curr (queue-remove! q)]
                       [r (car curr)]
                       [c (cadr curr)])

                  (if (and (= r end-r) (= c end-c))
                      #t ; Path found
                      (begin
                        ;; Move right
                        (let ([nr r] [nc (+ c 1)])
                          (when (and (< nc current-n)
                                     (= (vector-ref (vector-ref current-grid nr) nc) 1)
                                     (not (vector-ref (vector-ref visited nr) nc)))
                            (vector-set! (vector-ref visited nr) nc #t)
                            (queue-add! q (list nr nc))))
                        ;; Move down
                        (let ([nr (+ r 1)] [nc c])
                          (when (and (< nr current-m)
                                     (= (vector-ref (vector-ref current-grid nr) nc) 1)
                                     (not (vector-ref (vector-ref visited nr) nc)))
                            (vector-set! (vector-ref visited nr) nc #t)
                            (queue-add! q (list nr nc))))
                        (loop))))))))

  (call-with-current-continuation
   (lambda (return)
     ;; First, check if a path exists from (0,0) to (m-1,n-1) in the original grid.
     (unless (can-reach grid m n 0 0 (- m 1) (- n 1))
       ;; If no path exists, it's impossible to disconnect. Return true.
       (return #t))

     ;; Iterate through all possible cells (r,c) to flip.
     ;; Exclude (0,0) and (m-1,n-1) as they cannot be flipped.
     (for* ([r (in-range m)]
            [c (in-range n)])
       (when (and (or (> r 0) (> c 0)) ; Not (0,0)
                  (or (< r (- m 1)) (< c (- n 1))) ; Not (m-1,n-1)
                  (= (vector-ref (vector-ref grid r) c) 1))
         ;; Temporarily flip grid[r][c] to 0
         (vector-set! (vector-ref grid r) c 0)
         ;; Check if (0,0) can still reach (m-1,n-1)
         (when (not (can-reach grid m n 0 0 (- m 1) (- n 1)))
           ;; If not, we found a cell that disconnects all paths.
           ;; Restore grid[r][c] and return #f (we CAN disconnect).
           (vector-set! (vector-ref grid r) c 1)
           (return #f))) ; Early exit with #f

     ;; If the loop finishes, it means no single flip can disconnect all paths.
     ;; So it's impossible to disconnect. Return #t.
     #t)))