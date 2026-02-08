(define (closestEqualElement arr queries)
  (define (find-closest idx)
    (let loop ((i 0) (closest -1))
      (cond
        [(= i idx) (loop (+ i 1) closest)]
        [(= (vector-ref arr i) (vector-ref arr idx)) 
         (if (= closest -1) 
             (loop (+ i 1) i) 
             (loop (+ i 1) (min closest i)))]
        [else (loop (+ i 1) closest)]
      )))
  (map (lambda (q) (find-closest q)) queries))

(define (closestEqualElementQueries arr queries)
  (closestEqualElement (vector->list arr) (vector->list queries)))