#lang racket

(define (flip-board board r c piece-color)
  (let* ([m (length board)]
         [n (length (car board))]
         ;; Convert list of strings to vector of vectors of chars for efficient mutation
         [board-vec (list->vector (map (lambda (row) (list->vector (string->list row))) board))]
         [opponent-color (if (char=? piece-color #\B) #\W #\B)])

    ;; Helper function to check if coordinates are within board bounds
    (define (is-valid x y)
      (and (>= x 0) (< x m) (>= y 0) (< y n)))

    ;; Place the new piece on the board
    (vector-set! (vector-ref board-vec r) c piece-color)

    ;; Function to check a single direction for flips and perform them
    (define (check-and-flip start-r start-c dr dc)
      (let loop ([curr-r (+ start-r dr)]
                 [curr-c (+ start-c dc)]
                 [potential-flips '()])
        (cond
          ;; Out of bounds, no flip in this direction
          [(not (is-valid curr-r curr-c)) #f]
          ;; Found an opponent's piece, add to potential flips and continue
          [(char=? (vector-ref (vector-ref board-vec curr-r) curr-c) opponent-color)
           (loop (+ curr-r dr) (+ curr-c dc) (cons (list curr-r curr-c) potential-flips))]
          ;; Found a piece of the same color, and there were opponent pieces in between
          [(char=? (vector-ref (vector-ref board-vec curr-r) curr-c) piece-color)
           (if (not (null? potential-flips))
               ;; Perform the flips
               (for-each (lambda (pos)
                           (vector-set! (vector-ref board-vec (car pos)) (cadr pos) piece-color))
                         potential-flips)
               #f)] ; No opponent pieces to flip
          ;; Found an empty spot, no flip in this direction
          [else #f])))

    ;; Define all 8 directions
    (define drs '(-1 -1 -1 0 0 1 1 1))
    (define dcs '(-1 0 1 -1 1 -1 0 1))

    ;; Iterate through all 8 directions and apply flips
    (for-each (lambda (dr dc)
                (check-and-flip r c dr dc))
              drs dcs)

    ;; Convert the modified vector of vectors of chars back to a list of strings
    (map (lambda (row-vec) (list->string (vector->list row-vec))) (vector->list board-vec))))