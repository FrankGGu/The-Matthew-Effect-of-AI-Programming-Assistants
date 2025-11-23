(define (shortest-impossible-sequence rolls k)
  (let loop ([seen (make-hash)]
             [res 1]
             [i 0])
    (cond
      [(= (hash-count seen) k) (loop (make-hash) (+ res 1) i)]
      [(>= i (vector-length rolls)) res]
      [else
       (hash-set! seen (vector-ref rolls i) #t)
       (loop seen res (+ i 1))])))