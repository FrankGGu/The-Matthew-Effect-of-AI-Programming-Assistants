(define (stoneGameVII stones)
  (define n (length stones))
  (define dp (make-vector n 0))
  (define total (apply + stones))
  (define (helper left right)
    (if (= left right)
        0
        (begin
          (if (> (vector-ref dp left) 0)
              (vector-ref dp left)
              (begin
                (vector-set! dp left
                  (max 
                    (- (helper (add1 left) right) (vector-ref stones left))
                    (- (helper left (sub1 right)) (vector-ref stones right)))
                )
              ))
          (vector-ref dp left))))
  (helper 0 (sub1 n)))