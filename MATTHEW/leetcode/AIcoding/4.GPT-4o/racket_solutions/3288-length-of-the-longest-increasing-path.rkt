#lang racket

(define (longestIncreasingPath matrix)
  (define rows (length matrix))
  (define cols (if (zero? rows) 0 (length (first matrix))))
  (define dp (make-vector (* rows cols) -1))

  (define (in-bounds? x y)
    (and (>= x 0) (< x rows) (>= y 0) (< y cols)))

  (define (dfs x y)
    (if (vector-ref dp (+ x (* y cols))) 
        (vector-ref dp (+ x (* y cols)))
        (begin
          (define max-path 1)
          (for ([dx (list -1 1 0 0)]
                [dy (list 0 0 -1 1)])
            (define nx (+ x dx))
            (define ny (+ y dy))
            (when (in-bounds? nx ny)
              (when (> (vector-ref (vector-ref matrix x) y) (vector-ref (vector-ref matrix nx) ny))
                (set! max-path (max max-path (+ 1 (dfs nx ny))))))
          (vector-set! dp (+ x (* y cols)) max-path)
          max-path)))

  (define max-length 0)
  (for ([i (in-range rows)]
        [j (in-range cols)])
    (set! max-length (max max-length (dfs i j))))
  max-length)

(define (lengthOfLongestIncreasingPath matrix)
  (longestIncreasingPath matrix))