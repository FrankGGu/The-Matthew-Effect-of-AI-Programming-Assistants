(define (min-operations boxes)
  (let* ([n (string-length boxes)]
         [result (make-vector n 0)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (char=? (string-ref boxes j) #\1)
          (vector-set! result i (+ (vector-ref result i) (abs (- i j)))))))
    (vector->list result)))