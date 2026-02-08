(define (addSpaces s spaces)
  (let ([sb (make-string (string-length s) #\space)])
    (let loop ([i 0] [j 0] [k 0])
      (cond
        [(= i (length spaces)) 
         (substring sb 0 j)]
        [(= j (string-length s)) 
         (substring sb 0 j)]
        [else
         (if (and (< k (length spaces)) 
                  (= j (list-ref spaces k)))
             (begin
               (string-set! sb j #\space)
               (loop (if (< k (length spaces)) (+ k 1) k) (+ j 1) (+ j 1)))
             (begin
               (string-set! sb j (string-ref s i))
               (loop (if (< i (string-length s)) (+ i 1) i) (+ j 1) k)))]))))