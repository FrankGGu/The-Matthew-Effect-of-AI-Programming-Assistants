(define (count-fertile-pyramids land)
  (define rows (length land))
  (define cols (length (car land)))
  (define dp (make-vector rows (make-vector cols 0)))

  (define (calculate-dp)
    (for ([i (in-range rows)]
          [j (in-range cols)])
      (if (= (list-ref (list-ref land i) j) 1)
          (begin
            (if (and (> i 0) (> j 0) (< j (- cols 1)))
                (vector-set! (vector-ref dp i) j (+ 1 (min (vector-ref (vector-ref dp (- i 1)) (- j 1))
                                                              (vector-ref (vector-ref dp (- i 1)) j)
                                                              (vector-ref (vector-ref dp (- i 1)) (+ j 1))))))
            (vector-set! (vector-ref dp i) j 1))
          (vector-set! (vector-ref dp i) j 0))))

  (define (count-pyramids)
    (let loop ([i 0] [count 0])
      (if (= i rows)
          count
          (let loop2 ([j 0] [count2 count])
            (if (= j cols)
                (loop (+ i 1) count2)
                (loop2 (+ j 1) (+ count2 (vector-ref (vector-ref dp i) j))))))))

  (calculate-dp)
  (let ([pyramids (count-pyramids)])
    (define (reverse-land)
      (reverse land))
    (calculate-dp)
    (+ pyramids (count-pyramids))))

(define (count-fertile-pyramids-wrapper land)
  (- (count-fertile-pyramids land) (count-fertile-pyramids (map reverse land))))