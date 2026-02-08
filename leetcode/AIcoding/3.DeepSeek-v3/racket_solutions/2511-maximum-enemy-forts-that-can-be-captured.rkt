(define (maximum-captured-forts forts)
  (define (helper i j max-captured)
    (cond
      [(>= i (vector-length forts)) max-captured]
      [(= (vector-ref forts i) 1)
       (let loop ([k (add1 i)] [captured 0])
         (cond
           [(>= k (vector-length forts)) (helper (add1 i) (add1 i) max-captured)]
           [(= (vector-ref forts k) 0) (loop (add1 k) (add1 captured))]
           [(= (vector-ref forts k) 1) (helper (add1 i) (add1 i) max-captured)]
           [else (helper (add1 i) (add1 i) (max max-captured captured))]))]
      [else (helper (add1 i) j max-captured)]))
  (helper 0 0 0))