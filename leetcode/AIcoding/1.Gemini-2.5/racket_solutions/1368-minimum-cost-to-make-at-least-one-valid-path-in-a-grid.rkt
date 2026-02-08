#lang racket

(define (min-cost-path grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define dp (build-vector m (lambda (r) (build-vector n (lambda (c) +inf.0)))))

  ; Direction vectors for (right, left, down, up) corresponding to grid values 1, 2, 3, 4
  ; These are 0-indexed for iteration purposes (i=0 for right, i=1 for left, etc.)
  (define drs (vector 0 0 1 -1))
  (define dcs (vector 1 -1 0 0))

  ; Deque implementation using two lists for amortized O(1) operations
  (define front-list '())
  (define back-list '())

  (define (deque-push-front! item)
    (set! front-list (cons item front-list)))

  (define (deque-push-back! item)
    (set! back-list (cons item back-list)))

  (define (deque-pop-front!)
    (when (and (null? front-list) (not (null? back-list)))
      (set! front-list (reverse back-list))
      (set! back-list '()))
    (if (null? front-list)
        #f ; Should not be reached if deque-empty? is checked
        (let ([item (car front-list)])
          (set! front-list (cdr front-list))
          item)))

  (define (deque-empty?)
    (and (null? front-list) (null? back-list)))

  ; Initialize starting point
  (vector-set! (vector-ref dp 0) 0 0)
  (deque-push-front! (list 0 0))

  ; 0-1 BFS loop
  (let loop ()
    (unless (deque-empty?)
      (let* ([curr (deque-pop-front!)]
             [r (car curr)]
             [c (cadr curr)]
             [current-cost (vector-ref (vector-ref dp r) c)])

        ; Iterate over all 4 possible neighbor directions
        (for ([i (in-range 4)])
          (let* ([nr (+ r (vector-ref drs i))]
                 [nc (+ c (vector-ref dcs i))])

            ; Check if neighbor is within grid bounds
            (when (and (>= nr 0) (< nr m) (>= nc 0) (< nc n))
              ; Determine edge weight: 0 if it's the required direction, 1 otherwise
              ; grid-val (1-4) maps to i (0-3) as (grid-val - 1)
              (let* ([grid-val (vector-ref (vector-ref grid r) c)]
                     [edge-weight (if (= i (sub1 grid-val)) 0 1)]
                     [new-cost (+ current-cost edge-weight)])

                ; If a shorter path to (nr, nc) is found
                (when (< new-cost (vector-ref (vector-ref dp nr) nc))
                  (vector-set! (vector-ref dp nr) nc new-cost)
                  ; Add to front for 0-cost edges, back for 1-cost edges
                  (if (= edge-weight 0)
                      (deque-push-front! (list nr nc))
                      (deque-push-back! (list nr nc)))))))
        (loop)))) ; Continue the loop

  ; Return the minimum cost to reach the bottom-right cell
  (vector-ref (vector-ref dp (sub1 m)) (sub1 n)))