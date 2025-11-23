#lang racket

(define (solve heights-list queries-list)
  (define heights (list->vector heights-list))
  (define N (vector-length heights))
  (define Q (length queries-list))

  (define indexed-queries
    (for/vector ([i (in-range Q)]
                 [query queries-list])
      (list (car query) (cadr query) i)))

  (define results (make-vector Q -1))

  (define tree (make-vector (* 4 N) 0))

  (define (build node-idx start end)
    (if (= start end)
        (vector-set! tree node-idx (vector-ref heights start))
        (let ([mid (quotient (+ start end) 2)])
          (build (* 2 node-idx) start mid)
          (build (+ (* 2 node-idx) 1) (+ mid 1) end)
          (vector-set! tree node-idx (max (vector-ref tree (* 2 node-idx))
                                          (vector-ref tree (+ (* 2 node-idx) 1)))))))

  (define (query node-idx current-L current-R target-L target-R min-req-height)
    (if (or (> current-L target-R) (< current-R target-L))
        -1
        (if (< (vector-ref tree node-idx) min-req-height)
            -1
            (if (= current-L current-R)
                current-L
                (let ([mid (quotient (+ current-L current-R) 2)])
                  (let ([left-result (query (* 2 node-idx) current-L mid target-L target-R min-req-height)])
                    (if (not (= left-result -1))
                        left-result
                        (query (+ (* 2 node-idx) 1) (+ mid 1) current-R target-L target-R min-req-height))))))))

  (build 1 0 (- N 1))

  (for ([query-info (in-vector indexed-queries)])
    (let* ([a (car query-info)]
           [b (cadr query-info)]
           [original-idx (caddr query-info)]
           [max-idx (max a b)]
           [min-req-height (max (vector-ref heights a) (vector-ref heights b))])

      (vector-set! results original-idx
                   (query 1 0 (- N 1) max-idx (- N 1) min-req-height))))

  (vector->list results))