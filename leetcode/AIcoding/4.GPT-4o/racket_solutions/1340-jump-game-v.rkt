(define (max-jump-game-v arr d)
  (define n (length arr))
  (define (dp i)
    (if (>= i n) 0
        (if (vector-ref memo i)
            (vector-ref memo i)
            (let* ((max-jump (foldl (lambda (j acc)
                                       (if (and (< j i)
                                                 (<= (abs (- (vector-ref arr j) (vector-ref arr i))) d))
                                           (max acc (dp j))
                                           acc))
                                     0
                                     (range n)))
                   (result (+ max-jump 1)))
              (vector-set! memo i result)
              result))))
  (define memo (make-vector n #f))
  (foldl (lambda (i acc) 
            (max acc (dp i)))
          0
          (range n)))

(define (jump-game-v arr d)
  (max-jump-game-v arr d))