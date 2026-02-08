(define (max-path-sum grid)
  (let* ((m (length grid))
         (n (length (car grid)))
         (dp (make-vector m (make-vector n -1))))

    (vector-set! (vector-ref dp 0) 0 (vector-ref (car grid) 0))

    (define (solve r c)
      (cond
        [(and (= r (sub1 m)) (= c (sub1 n))) (vector-ref (vector-ref grid r) c)]
        [(vector-ref (vector-ref dp r) c) (vector-ref (vector-ref dp r) c)]
        [else
         (let ((down -1) (right -1))
           (when (< r (sub1 m))
             (set! down (+ (vector-ref (vector-ref grid r) c) (solve (add1 r) c))))
           (when (< c (sub1 n))
             (set! right (+ (vector-ref (vector-ref grid r) c) (solve r (add1 c)))))

           (let ((max-val (max down right)))
             (vector-set! (vector-ref dp r) c max-val)
             max-val))]))

    (solve 0 0)))