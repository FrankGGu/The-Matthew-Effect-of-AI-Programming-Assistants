#lang racket

(define (find-paths m n max-move start-row start-column)
  (define mod 1000000007)
  (define dp (make-vector max-move (make-vector m (make-vector n 0))))

  (define (helper move i j)
    (cond
      [(or (< i 0) (>= i m) (< j 0) (>= j n)] 1]
      [(zero? move)] 0]
      [(not (zero? (vector-ref (vector-ref (vector-ref dp (sub1 move)) i) j)))
       (vector-ref (vector-ref (vector-ref dp (sub1 move)) i) j)]
      [else
       (let ([res (modulo (+ (helper (sub1 move) (sub1 i) j)
                             (helper (sub1 move) (add1 i) j)
                             (helper (sub1 move) i (sub1 j))
                             (helper (sub1 move) i (add1 j)))
                           mod)])
         (vector-set! (vector-ref (vector-ref dp (sub1 move)) i j res)
         res)]))

  (helper max-move start-row start-column))