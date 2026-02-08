(define (stone-game-vi alice-values bob-values)
  (let* ([n (length alice-values)]
         [values (make-vector n)]
         [indices (make-vector n)])
    (for ([i (in-range n)])
      (vector-set! values i (+ (list-ref alice-values i) (list-ref bob-values i)))
      (vector-set! indices i i))
    (sort! indices (lambda (i j) (> (vector-ref values i) (vector-ref values j))))
    (let loop ([i 0] [alice-score 0])
      (if (= i n)
          (cond
            [(> alice-score (- (apply + bob-values) alice-score)) 1]
            [(< alice-score (- (apply + bob-values) alice-score)) -1]
            [else 0])
          (let ([index (vector-ref indices i)])
            (if (even? i)
                (loop (+ i 1) (+ alice-score (list-ref alice-values index)))
                (loop (+ i 1) alice-score)))))))