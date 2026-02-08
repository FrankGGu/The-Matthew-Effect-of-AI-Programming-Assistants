(define (stoneGameIII stoneValue)
  (define n (length stoneValue))
  (define dp (make-vector (+ n 1) 0))
  (define (max-sum i)
    (if (>= i n) 0
        (if (not (= (vector-ref dp i) 0)) (vector-ref dp i)
            (let loop ((j 1) (total 0) (best -1e9))
              (if (> j 3) 
                  (begin (vector-set! dp i best) best)
                  (begin
                    (set! total (+ total (vector-ref stoneValue (+ i (- j 1)))))
                    (loop (+ j 1) total (max best (- total (max-sum (+ i j))))))))))
  (if (> (max-sum 0) 0) "Alice" (if (< (max-sum 0) 0) "Bob" "Tie")))