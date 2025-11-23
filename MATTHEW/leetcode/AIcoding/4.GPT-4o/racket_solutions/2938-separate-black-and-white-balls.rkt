(define (sortBalls balls)
  (let ([count (make-vector 2 0)])
    (for-each (lambda (ball)
                (vector-set! count ball (+ (vector-ref count ball) 1)))
              balls)
    (let loop ([i 0] [j 0])
      (cond
        [(= i (vector-ref count 0)) (vector-fill! balls 1 j)]
        [(< j (vector-ref count 0)) (begin (vector-set! balls j 0) (loop (add1 i) (add1 j)))]
        [else (begin (vector-set! balls j 1) (loop i (add1 j)))])))))

(define (sortArray nums)
  (sortBalls nums)
  nums)