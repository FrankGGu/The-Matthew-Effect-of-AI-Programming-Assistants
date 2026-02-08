(define (strange-printer s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))

  (define (solve l r)
    (cond
      [(> l r) 0]
      [(= l r) 1]
      [(positive? (vector-ref (vector-ref dp l) r)) (vector-ref (vector-ref dp l) r)]
      [else
       (let loop ([k l] [min-val (+ r 1)])
         (cond
           [(= k r) min-val]
           [else
            (let ([val (+ (solve l k) (solve (+ k 1) r) (if (char=? (string-ref s l) (string-ref s (+ k 1))) -1 0))])
              (loop (+ k 1) (min min-val val))))])
       (let ([result (loop l (+ r 1))])
         (vector-set! (vector-ref dp l) r result)
         result)]))

  (solve 0 (- n 1)))