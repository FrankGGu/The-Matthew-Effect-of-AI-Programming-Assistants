(define (findClosestElements arr k x)
  (define (binary-search left right)
    (if (= left right)
        left
        (let ((mid (+ left (/ (- right left) 2))))
          (if (< (vector-ref arr mid) x)
              (binary-search (+ mid 1) right)
              (binary-search left mid)))))

  (define idx (binary-search 0 (vector-length arr)))
  (define left (max 0 (- idx 1)))
  (define right idx)

  (define result '())

  (for ([i (in-range k)])
    (if (or (< left 0) (and (< right (vector-length arr)) 
                             (< (abs (- (vector-ref arr left) x)) 
                                (abs (- (vector-ref arr right) x)))))
        (begin
          (set! result (cons (vector-ref arr left) result))
          (set! left (sub1 left)))
        (begin
          (set! result (cons (vector-ref arr right) result))
          (set! right (add1 right)))))

  (sort result <))