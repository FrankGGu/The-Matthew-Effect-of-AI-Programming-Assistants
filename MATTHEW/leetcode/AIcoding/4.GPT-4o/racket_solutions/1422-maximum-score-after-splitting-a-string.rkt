(define (maxScore s)
  (define n (string-length s))
  (define left-ones (make-vector (+ n 1) 0))
  (define right-zeros (make-vector (+ n 1) 0))

  (for ([i (in-range n)])
    (vector-set! left-ones (+ i 1) (+ (vector-ref left-ones i) (if (char=? (string-ref s i) #\1) 1 0))))

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! right-zeros i (+ (vector-ref right-zeros (+ i 1)) (if (char=? (string-ref s i) #\0) 1 0))))

  (define max-score 0)
  (for ([i (in-range (+ n 1))])
    (set! max-score (max max-score (+ (vector-ref left-ones i) (vector-ref right-zeros i)))))

  max-score)