(define (first-complete-row-or-column hits rows cols)
  (define row-counts (make-vector rows 0))
  (define col-counts (make-vector cols 0))
  (for/first ([i (in-range 0 (length hits))]
              #:when (let ([row (vector-ref (list-ref hits i) 0)]
                          [col (vector-ref (list-ref hits i) 1)])
                      (begin
                        (vector-set! row-counts row (+ (vector-ref row-counts row) 1))
                        (vector-set! col-counts col (+ (vector-ref col-counts col) 1))
                        (or (= (vector-ref row-counts row) cols)
                            (= (vector-ref col-counts col) rows)))))
    (+ i 1)))