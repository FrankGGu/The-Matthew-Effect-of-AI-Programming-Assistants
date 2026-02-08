#lang racket

(define (number-of-black-blocks m n coordinates)
  (define black-cells (make-hash)) ; Stores (r . c) for black cells for O(1) lookup
  (for-each
   (lambda (coord)
     (hash-set! black-cells (cons (car coord) (cadr coord)) #t))
   coordinates)

  (define relevant-squares (make-hash)) ; Stores unique (R . C) for top-left corners of 2x2 squares that contain at least one black cell

  (for-each
   (lambda (coord)
     (define r (car coord))
     (define c (cadr coord))

     ; A black cell (r, c) can be part of four 2x2 squares.
     ; The top-left corners of these squares are:
     ; (r, c)   - (r,c) is top-left
     ; (r, c-1) - (r,c) is top-right
     ; (r-1, c) - (r,c) is bottom-left
     ; (r-1, c-1) - (r,c) is bottom-right

     (for* ((dr (in-range 0 2))
            (dc (in-range 0 2)))
       (define R (- r dr))
       (define C (- c dc))

       ; Check if this (R, C) forms a valid 2x2 square within the m x n grid
       ; A 2x2 square from (R,C) to (R+1, C+1) is valid if R+1 < m and C+1 < n
       ; which means R < m-1 and C < n-1.
       ; Also R and C must be non-negative.
       (when (and (>= R 0) (>= C 0) (< R (- m 1)) (< C (- n 1)))
         (hash-set! relevant-squares (cons R C) #t))))
   coordinates)

  (define ans (make-vector 5 0))

  (hash-for-each
   (lambda (rc-key _) ; _ is the value, which is just #t, not needed
     (define R (car rc-key))
     (define C (cdr rc-key))

     (define current-black-count 0)
     (when (hash-has-key? black-cells (cons R C)) (set! current-black-count (add1 current-black-count)))
     (when (hash-has-key? black-cells (cons (+ R 1) C)) (set! current-black-count (add1 current-black-count)))
     (when (hash-has-key? black-cells (cons R (+ C 1))) (set! current-black-count (add1 current-black-count)))
     (when (hash-has-key? black-cells (cons (+ R 1) (+ C 1))) (set! current-black-count (add1 current-black-count)))

     (vector-set! ans current-black-count (add1 (vector-ref ans current-black-count))))
   relevant-squares)

  (define total-possible-2x2-squares (* (max 0 (- m 1)) (max 0 (- n 1))))

  (define num-squares-with-black-cells (hash-count relevant-squares))

  (when (> total-possible-2x2-squares num-squares-with-black-cells)
    (vector-set! ans 0
                 (+ (vector-ref ans 0)
                    (- total-possible-2x2-squares num-squares-with-black-cells))))

  ans)