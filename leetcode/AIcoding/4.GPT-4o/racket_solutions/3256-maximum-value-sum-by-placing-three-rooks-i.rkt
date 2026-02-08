(define (maxValueSum grid)
  (define (max-in-list lst)
    (apply max lst))
  (define (max-row-sum r)
    (max-in-list (map (lambda (c) (if (zero? (vector-ref grid r c)) 0 (vector-ref grid r c))) (range (vector-length grid)))))
  (define (max-col-sum c)
    (max-in-list (map (lambda (r) (if (zero? (vector-ref grid r c)) 0 (vector-ref grid r c))) (range (vector-length grid)))))

  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))

  (define max-sum 0)

  (for ([r (in-range rows)]
        [c (in-range cols)])
    (define current-sum (+ (max-row-sum r) (max-col-sum c)))
    (set! max-sum (max max-sum current-sum)))

  max-sum)