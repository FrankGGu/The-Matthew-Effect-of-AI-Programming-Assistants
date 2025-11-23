(define (candy ratings)
  (define n (length ratings))

  (when (zero? n)
    (error 'candy "ratings list cannot be empty")) ; LeetCode usually passes non-empty or expects 0 for empty. Problem constraints say n >= 1.

  (define ratings-vec (list->vector ratings))
  (define candies-vec (build-vector n (lambda (i) 1)))

  ; First pass: Left to right
  (for ([i (in-range 1 n)])
    (when (> (vector-ref ratings-vec i) (vector-ref ratings-vec (- i 1)))
      (vector-set! candies-vec i (+ (vector-ref candies-vec (- i 1)) 1))))

  ; Second pass: Right to left
  (for ([i (in-range (- n 2) -1 -1)])
    (when (> (vector-ref ratings-vec i) (vector-ref ratings-vec (+ i 1)))
      (vector-set! candies-vec i (max (vector-ref candies-vec i)
                                      (+ (vector-ref candies-vec (+ i 1)) 1)))))

  ; Sum the candies
  (apply + (vector->list candies-vec)))