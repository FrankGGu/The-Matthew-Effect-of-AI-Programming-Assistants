(define (count-servers grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))

  (if (or (= rows 0) (= cols 0))
      0
      (begin
        (define row-counts (make-vector rows 0))
        (define col-counts (make-vector cols 0))

        (for ([r (in-range rows)])
          (for ([c (in-range cols)])
            (when (= (list-ref (list-ref grid r) c) 1)
              (vector-set! row-counts r (+ (vector-ref row-counts r) 1))
              (vector-set! col-counts c (+ (vector-ref col-counts c) 1)))))

        (define communicating-servers 0)
        (for ([r (in-range rows)])
          (for ([c (in-range cols)])
            (when (= (list-ref (list-ref grid r) c) 1)
              (when (or (> (vector-ref row-counts r) 1)
                        (> (vector-ref col-counts c) 1))
                (set! communicating-servers (+ communicating-servers 1))))))
        communicating-servers)))