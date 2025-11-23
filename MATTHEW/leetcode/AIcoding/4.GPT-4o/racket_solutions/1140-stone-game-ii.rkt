(define (stoneGameII piles)
  (define n (length piles))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))

  (define (helper i m)
    (if (>= i n) 0
        (if (vector-ref dp i m) 
            (vector-ref dp i m)
            (let loop ((x 1) (max-stones 0))
              (if (> x (* 2 m)) 
                  max-stones
                  (let ((total (apply + (take piles (min n (+ i x))))))
                    (set! max-stones (max max-stones (- total (helper (+ i x) (max m x)))))
                    (loop (+ x 1) max-stones))))))
  (helper 0 1))

(define (stoneGameIIWrapper piles)
  (stoneGameII piles))

(stoneGameIIWrapper '(2 7 9 4 4)) ; Example usage to test the function